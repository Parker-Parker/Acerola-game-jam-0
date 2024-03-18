# import zipfile
# zip = zipfile.ZipFile("./BUILD/game.love", "w", zipfile.ZIP_DEFLATED)
# zip.write("test.txt")
# zip.close()

import shutil
# import os

shutil.make_archive("./BUILD/game.love", 'zip', "./SRC/")
shutil.move("./BUILD/game.love.zip","./BUILD/game.love")


shutil.rmtree("./BUILD/Win/", ignore_errors=True)

# os.makedirs("./BUILD/Win/")
# shutil.unpack_archive("./BUILD/love-11.5-win64.zip", "./BUILD/Win/", "zip")

shutil.unpack_archive("./BUILD/love-11.5-win64.zip", "./BUILD/", "zip")
shutil.move("./BUILD/love-11.5-win64","./BUILD/Win/")

shutil.copy("./BUILD/Win/love.exe","./BUILD/Win/SuperGame.exe")
with open("./BUILD/Win/SuperGame.exe", "ab") as loveEXE, open("./BUILD/game.love", "rb") as gameData:
    loveEXE.write(gameData.read())

shutil.make_archive("./BUILD/SuperGameWin", 'zip', "./BUILD/Win/")





