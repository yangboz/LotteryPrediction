import tensorflow as tf
from tensorflow.keras import layers
from tensorflow.keras import models

# 定义模型的输入和输出
inputs = layers.Input(shape=(7,))
outputs = layers.Dense(7, activation='softmax')(inputs)

# 定义Transformer模型
transformer_layer = layers.MultiHeadAttention(num_heads=8, key_dim=64)
transformer = transformer_layer(inputs, inputs)
transformer = layers.Dropout(0.1)(transformer)
transformer = layers.LayerNormalization(epsilon=1e-6)(inputs + transformer)
transformer = layers.Dense(128, activation='relu')(transformer)
transformer = layers.Dense(7, activation='softmax')(transformer)

# 构建模型
model = models.Model(inputs=[inputs], outputs=[outputs])

# 编译模型
model.compile(optimizer='adam', loss='categorical_crossentropy', metrics=['accuracy'])

# 输出模型的概述
model.summary()


#
import pandas as pd
import numpy as np

# 读取历史数据
data = pd.read_csv('data.csv')

# 将开奖号码转换为向量
def to_vector(numbers):
    vector = np.zeros(33)
    for number in numbers:
        vector[number-1] = 1
    return vector

# 将数据转换为模型的输入和输出
X = np.array([to_vector(numbers) for numbers in data.iloc[:, 1:].values])
y = np.array([to_vector(numbers) for numbers in data.iloc[:, 1:].shift(-1).fillna(0).values])


#
from tensorflow.keras.callbacks import ModelCheckpoint

# 定义模型的输入和输出
inputs = layers.Input(shape=(33,))
outputs = layers.Dense(33, activation='softmax')(inputs)

# 定义Transformer模型
transformer_layer = layers.MultiHeadAttention(num_heads=8, key_dim=64)
transformer = transformer_layer(inputs, inputs)
transformer = layers.Dropout(0.1)(transformer)
transformer = layers.LayerNormalization(epsilon=1e-6)(inputs + transformer)
transformer = layers.Dense(128, activation='relu')(transformer)
transformer = layers.Dense(33, activation='softmax')(transformer)

# 构建模型
model = models.Model(inputs=[inputs], outputs=[outputs])

# 编译模型
model.compile(optimizer='adam', loss='categorical_crossentropy', metrics=['accuracy'])

设置模型检查点

checkpoint = ModelCheckpoint('model.h5', save_best_only=True, save_weights_only=True, monitor='val_loss', mode='min')

#训练模型

history = model.fit(X, y, batch_size=64, epochs=50, validation_split=0.1, callbacks=[checkpoint])


#在这个代码中，我们定义了一个名为`ModelCheckpoint`的回调函数，它将在每个epoch结束时保存模型的权重，并只保存在验证集上性能最好的模型。我们还使用了一个验证集来检查模型的性能，以便及早停止训练并防止过拟合。

### 模型预测

#现在，我们可以使用训练好的模型来预测下一期的开奖号码了。首先，我们需要将当前的开奖号码转换为模型的输入格式。然后，我们可以使用训练好的模型来预测下一期的开奖号码，并将其转换为实际的号码。

# ```python
# 获取当前的开奖号码
current_numbers = [2, 4, 6, 8, 10, 12, 14]

# 将开奖号码转换为向量
current_vector = to_vector(current_numbers)

# 预测下一期的开奖号码
predicted_vector = model.predict(np.array([current_vector]))[0]
predicted_numbers = [i+1 for i, value in enumerate(predicted_vector) if value > 0.5]

# 输出预测结果
print('下一期的开奖号码为：', predicted_numbers)

