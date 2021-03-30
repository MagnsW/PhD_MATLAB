function [output] = spect_analysis(amps,f)
%UNTITLED Summary of this function goes here
%   Check Rose page 463

[output.peak_amp, peak_amp_index] = max(amps);
output.f_peak = f(peak_amp_index);

% Find the half max value.
output.halfMax = (min(amps) + max(amps)) * 0.5;
output.ninetyperc = (min(amps) + max(amps)) * 0.9;
output.tenperc = (min(amps) + max(amps)) * 0.1;

    function [freq1, freq2, index1, index2] = findfreq(data, fs, value)
        index1 = find(data >= value, 1, 'first');
        index2 = find(data >= value, 1, 'last');
        freq1 = fs(index1);
        freq2 = fs(index2);
    end
[output.f1, output.f4, output.f1_idx, output.f4_idx] = findfreq(amps, f, output.tenperc);
[output.f2, output.f3, output.f2_idx, output.f3_idx] = findfreq(amps, f, output.ninetyperc);
[output.f5, output.f6, output.f5_idx, output.f6_idx] = findfreq(amps, f, output.halfMax);



output.fwhm_f_range = output.f6 - output.f5;
output.spect_rise_rate = output.f2 - output.f1;
output.spect_fall_rate = output.f4 - output.f3;



end

