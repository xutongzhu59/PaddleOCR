import matplotlib.pyplot as plt

# Data size in MB
data_size = [10, 20, 30, 40, 50]

# F-measure values for different methods
method1_f_measure = [0.85, 0.92, 0.89, 0.95, 0.91]
method2_f_measure = [0.78, 0.86, 0.82, 0.88, 0.84]
method3_f_measure = [0.92, 0.94, 0.91, 0.96, 0.93]

# Plotting the data
plt.plot(data_size, method1_f_measure, marker='o', linestyle='-', color='b', label='Method 1')
plt.plot(data_size, method2_f_measure, marker='s', linestyle='--', color='r', label='Method 2')
plt.plot(data_size, method3_f_measure, marker='^', linestyle='-.', color='g', label='Method 3')

plt.xlabel('Data Size (MB)')
plt.ylabel('F-measure')
plt.title('Data Size vs F-measure')
plt.grid(True)
plt.legend()
plt.show()