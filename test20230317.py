import torch
import torch.nn as nn
import numpy as np
from typing import Tuple

class CustomTransformer(nn.Module):
    def __init__(self, input_dim: int, output_dim: int, nhead: int, num_layers: int):
        super().__init__()
        self.transformer = nn.TransformerEncoder(nn.TransformerEncoderLayer(input_dim, nhead), num_layers)
        self.fc = nn.Linear(input_dim, output_dim)

    def forward(self, x: torch.Tensor) -> torch.Tensor:
        out = self.transformer(x)
        out = out[:, -1, :]
        out = self.fc(out)
        return out

def split_sequences(data: np.ndarray, window_size: int) -> Tuple[np.ndarray, np.ndarray]:
    X, y = [], []
    for i in range(len(data)-window_size):
        X.append(data[i:i+window_size])
        y.append(data[i+window_size])
    return np.array(X), np.array(y)

model = CustomTransformer(input_dim=10, output_dim=1, nhead=2, num_layers=4)

def train_model(X_train, y_train, epochs):
    criterion = nn.MSELoss()
    optimizer = torch.optim.Adam(model.parameters(), lr=0.001)
    for epoch in range(epochs):
        optimizer.zero_grad()
        outputs = model(X_train)
        loss = criterion(outputs, y_train)
        loss.backward()
        optimizer.step()
        print(f"Epoch {epoch+1}/{epochs}, Loss: {loss.item()}")

def predict(model, data, window_size):
    inputs = data[-window_size:].reshape(1,-1)
    inputs = torch.from_numpy(inputs).float()
    model.eval()
    for i in range(window_size):
        output = model(inputs)
        inputs = torch.cat([inputs[:,1:], output], axis=1)
    return output.item()

# 生成示例数据
data = np.random.randn(500)
train_data = data[:400]
test_data = data[400:]

# 拆分时间窗口数据
window_size = 20
X_train, y_train = split_sequences(train_data, window_size)
X_test, y_test = split_sequences(test_data, window_size)

# 训练模型
train_model(torch.from_numpy(X_train).float(), torch.from_numpy(y_train).float(), epochs=100)

# 预测结果
predictions = []
for i in range(len(X_test)):
    x_input = X_test[i].reshape(1, window_size)
    yhat = predict(model, x_input, window_size)
    predictions.append(yhat)

# 打印结果
print(predictions)

