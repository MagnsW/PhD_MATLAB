function [s_data_return, kurts] = wavelet_analysis(s_data)
s_data_return = s_attributes(s_data);
kurts = kurtosis(s_data.traces, 1, 1);
end
