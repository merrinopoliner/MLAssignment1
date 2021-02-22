function plotConfusion(samples, decisions, labels)

dec11 = find(decisions==1 & labels==1);
dec12 = find(decisions==1 & labels==2);
dec13 = find(decisions==1 & labels==3);
dec21 = find(decisions==2 & labels==1);
dec22 = find(decisions==2 & labels==2);
dec23 = find(decisions==2 & labels==3);
dec31 = find(decisions==3 & labels==1);
dec32 = find(decisions==3 & labels==2);
dec33 = find(decisions==3 & labels==3);

plot3(samples(1, dec11), samples(2, dec11), samples(3, dec11), 'og');
hold on;
plot3(samples(1, [dec12,dec13]), samples(2,[dec12,dec13]), samples(3,[dec12,dec13]), 'or');

plot3(samples(1, dec22), samples(2, dec22), samples(3, dec22), '+g');
plot3(samples(1, [dec21,dec23]), samples(2,[dec21,dec23]), samples(3,[dec21,dec23]), '+r');

plot3(samples(1, dec33), samples(2, dec33), samples(3, dec33), 'xg');
plot3(samples(1, [dec31,dec32]), samples(2,[dec31,dec32]), samples(3,[dec31,dec32]), 'xr');

end