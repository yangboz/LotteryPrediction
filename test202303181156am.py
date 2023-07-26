import torch
from torch import nn
import pandas as pd
from torch.utils.data import Dataset, DataLoader

# 定义Transformer模型
class TransformerModel(nn.Module):
    def __init__(self, num_features, num_layers, num_heads, dropout):
        super(TransformerModel, self).__init__()
        self.encoder_layer = nn.TransformerEncoderLayer(num_features, num_heads, dropout)
        self.transformer_encoder = nn.TransformerEncoder(self.encoder_layer, num_layers)
        self.decoder_layer = nn.TransformerDecoderLayer(num_features, num_heads, dropout)
        self.transformer_decoder = nn.TransformerDecoder(self.decoder_layer, num_layers)
        self.linear = nn.Linear(num_features, 1)
    
    def forward(self, src, tgt):
        src = src.permute(1, 0, 2)  # 转置张量以适应Transformer模型
        tgt = tgt.permute(1, 0, 2)
        memory = self.transformer_encoder(src)
        output = self.transformer_decoder(tgt, memory)
        output = self.linear(output[-1])
        return output

# 定义彩票数据集
class LotteryDataset(Dataset):
    def __init__(self, data):
        self.data = data
        
    def __len__(self):
        return len(self.data) - 7  # 每次使用7个前一个


    def __getitem__(self, idx):
        src = torch.tensor(self.data[idx:idx+7]).float()  # 前7个彩票号码为输入
        tgt = torch.tensor(self.data[idx+7]).float()  # 第8个彩票号码为输出
        return src, tgt
    
# 训练函数
def train(model, train_loader, optimizer, criterion, device):
    model.train()
    train_loss = 0
    for batch_idx, (data, target) in enumerate(train_loader):
        data, target = data.to(device), target.to(device)
        optimizer.zero_grad()
        output = model(data, data)
        loss = criterion(output.view(-1), target)
        loss.backward()
        optimizer.step()
        train_loss += loss.item()
    return train_loss / len(train_loader.dataset)

# 测试函数
def test(model, test_loader, criterion, device):
    model.eval()
    test_loss = 0
    with torch.no_grad():
        for data, target in test_loader:
            data, target = data.to(device), target.to(device)
            output = model(data, data)
            test_loss += criterion(output.view(-1), target).item()
    return test_loss / len(test_loader.dataset)

# 训练模型
def train_model(model, train_loader, test_loader, optimizer, criterion, device, epochs=10):
    train_losses = []
    test_losses = []
    for epoch in range(1, epochs+1):
        train_loss = train(model, train_loader, optimizer, criterion, device)
        test_loss = test(model, test_loader, criterion, device)
        train_losses.append(train_loss)
        test_losses.append(test_loss)
        print('Epoch: {} \tTraining Loss: {:.6f} \tTesting Loss: {:.6f}'.format(
            epoch, train_loss, test_loss))
    return train_losses, test_losses

# 预测函数
def predict(model, data, device):
    model.eval()
    with torch.no_grad():
        input_data = torch.tensor(data[-7:]).float().unsqueeze(0).to(device)
        output = model(input_data, input_data)
        prediction = round(output.item())
    return prediction

# 主程序
if __name__ == '__main__':
    # 读取彩票数据
    data= pd.read_csv('data.csv',sep=';', header=7, names=[ 'r1','r2','r3','r4','r5','r6','b1'])
    print("raw data:",data)

    data= data.values.tolist()

    print("tolisted data:",data,"and typeof:",type(data))

    # 定义超参数
    num_features = 1
    num_layers = 2
    num_heads = 2
    dropout = 0.1
    lr = 0.001
    batch_size = 32
    epochs = 10

    # 数据准备
    dataset = LotteryDataset(data)
    train_dataset, test_dataset = torch.utils.data.random_split(dataset, [len(dataset)-100, 100])
    train_loader = DataLoader(train_dataset, batch_size=batch_size, shuffle=True)
    test_loader = DataLoader(test_dataset, batch_size=batch_size, shuffle=False)

    # 定义模型和优化器
    model = TransformerModel(num_features, num_layers, num_heads, dropout)
    optimizer = torch.optim.Adam(model.parameters(), lr=lr)
    criterion = nn.MSELoss()

    # 训练模型
    device = torch.device('cuda' if torch.cuda.is_available() else 'cpu')
    model.to(device)
