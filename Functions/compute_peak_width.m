
% calculate the peak width and the start and end points
function [peak_width, t_peak_start, t_peak_end, area] = compute_peak_width(x, y, Dy, index)

index_r = index + 1;
while(Dy(index_r) < 0)
    if (index_r < length(Dy))
        index_r = index_r + 1;
    else
        break;
    end
end

index_l = index;
while(Dy(index_l - 1) > 0)
    if (index_l > 1)
        index_l = index_l - 1;
    else
        break;
    end
end

t_peak_start = x(index_l);
t_peak_end = x(index_r);
peak_width = abs(x(index_l) - x(index_r));

area = trapz(x(index_l + 1:index_r - 1), y(index_l + 1:index_r - 1));

end