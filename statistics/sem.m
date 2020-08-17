function y = sem(x)
y = std(x,'omitnan') / sqrt(size(x,2));
end