@echo off
chcp 1252
:MOUNTER
CLS
ECHO:
ECHO Montador de imagens - Por Rafael Costa.
echo:
echo 1- Montar WIM.
echo 2- Desmontar WIM.
echo:
SET /P IMG="Digite uma tarefa: "
IF %IMG% EQU 2 GOTO 2
ECHO:
:WIM
SET /P WIM="[1/3] Arraste para esta janela o arquivo WIM a ser montado: "
DISM /GET-WIMINFO /WIMFILE:%WIM%
ECHO:
SET /P INDEX="[2/3] Selecione o INDEX (Indice) da imagem desejada: "
ECHO:
:FOLDER
SET /P FOLDER="[3/3] O conteudo do WIM selecionado sera extraido para uma nova pasta. Digite o nome da pasta a ser criada. A pasta sera criada em C: "
IF EXIST %HOMEDRIVE%\%FOLDER%\*.* (GOTO ERRO) ELSE GOTO OK
:ERRO
ECHO:
ECHO Essa pasta ja existe. Tente um nome diferente.
ECHO:
GOTO FOLDER
:ok
MD %HOMEDRIVE%\%FOLDER%
ECHO:
ECHO A imagem esta sendo montada em C:\%FOLDER%. Por favor, aguarde.
DISM /MOUNT-WIM /WIMFILE:%WIM% /INDEX:%INDEX% /MOUNTDIR:%HOMEDRIVE%\%FOLDER%
ECHO:
set /p startnet="Deseja editar startnet.cmd? (S/N) "
IF /I %startnet% EQU S notepad %HOMEDRIVE%\%FOLDER%\Windows\System32\startnet.cmd
echo:
SET /P DONE="Voltar ao menu principal? (S/N) "
IF /I %DONE% EQU S GOTO MOUNTER
EXIT
:2
ECHO:
:UNMOUNT
SET /P UNMOUNT="Diretorio da imagem a ser desmontada: "
echo:
SET /P NSAVE="Voce deseja salvar as alteracoes realizadas na imagem? (S/N) "
IF /i %NSAVE% EQU N GOTO 3
DISM /UNMOUNT-WIM /MOUNTDIR:%UNMOUNT% /COMMIT
RD /S /Q %UNMOUNT%
ECHO:
SET /P DONE2="Voltar ao menu principal? (S/N) "
IF /I %DONE2% EQU S GOTO MOUNTER
EXIT
:3
DISM /UNMOUNT-WIM /MOUNTDIR:%UNMOUNT% /DISCARD
RD /S /Q %UNMOUNT%
ECHO:
SET /P DONE3="Voltar ao menu principal? (S/N) "
IF /I %DONE3% EQU S GOTO MOUNTER
EXIT



