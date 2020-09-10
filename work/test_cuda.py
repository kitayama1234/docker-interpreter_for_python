import torch
import torch.nn as nn
import time


if torch.cuda.is_available():
    device = torch.device("cuda:0")
    print("cuda is available.")
else:
    device = torch.device("cpu")
    print("cuda is not available.")

x = torch.rand([100, 100]).to(device)

layer = nn.Sequential(
          nn.Linear(100, 2000),
          nn.ReLU(),
          nn.Linear(2000, 10000),
          nn.ReLU(),
          nn.Linear(10000, 10000),
          nn.ReLU(),
          nn.Linear(10000, 2000),
          nn.ReLU(),
          nn.Linear(2000, 10)
        ).to(device)

print("start")
start_time = time.time()
for _ in range(100):
    out = layer(x)
end_time = time.time()
    
print("end (time:%f)" % (end_time - start_time))

print(x.device)
print(out.device)



