function y = sem(x)
y = std(x,'omitnan') / sqrt(size(x,1));
end