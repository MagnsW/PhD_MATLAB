r1 = make_random_model(64, 1280, 2);
r2 = make_random_model(64, 1280, 4);
r3 = make_random_model(64, 1280, 6);
r4 = make_random_model(64, 1280, 8);
r5 = make_random_model(64, 1280, 12);
figure
subplot(5,1,1)
imagesc(r1)
axis equal
title('Max depth = 2')
set(gca,'xtick',[])
subplot(5,1,2)
imagesc(r2)
axis equal
title('Max depth = 4')
set(gca,'xtick',[])
subplot(5,1,3)
imagesc(r3)
axis equal
title('Max depth = 8')
set(gca,'xtick',[])
subplot(5,1,4)
imagesc(r4)
axis equal
title('Max depth = 12')
set(gca,'xtick',[])
subplot(5,1,5)
imagesc(r5)
axis equal
title('Max depth = 64')
set(gca,'xtick',[])