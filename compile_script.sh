# zip -r ../BUILD\?/game.zip ../SRC\?\?/*
# zip -r ./BUILD/game.zip ../SRC/
# zip -r ../BUILD\?/game.zip ../SRC\?\?/*
# zip -r ./BUILD/game.love ./SRC/*   
# zip -r ./BUILD/game.zip ./SRC/*
  
cd ./SRC; zip -r ../BUILD/game.love ./* ; cd .. 
# chmod +x ./BUILD/game.love
# cd ./SRC; zip -r ../BUILD/game.zip ./*  ; cd ..
echo "cleaning win"; cd ./BUILD/Win;ls; rm ./*; rm -r ./*; cd ../..
echo "Extracting win";unzip -j ./BUILD/love-11.5-win64.zip  -d ./BUILD/Win
echo "Compiling win";cat ./BUILD/Win/love.exe ./BUILD/game.love > ./BUILD/Win/SuperGame.exe
chmod +x ./BUILD/Win/SuperGame.exe

cd ./BUILD/Win/; zip -rj ../SuperGameWin.zip ./* ; cd ../.. 
