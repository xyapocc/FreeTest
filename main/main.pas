// Copyright © 2015-2016 Mikhailov Nikita Sergeevich
//   This file is part of FreeTest.

//   FreeTest is free software: you can redistribute it and/or modify
//   it under the terms of the GNU General Public License as published by
//   the Free Software Foundation, either version 3 of the License, or
//   (at your option) any later version.

//   FreeTest is distributed in the hope that it will be useful,
//   but WITHOUT ANY WARRANTY; without even the implied warranty of
//   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
//   GNU General Public License for more details.

//   You should have received a copy of the GNU General Public License
//   along with FreeTest.  If not, see <http://www.gnu.org/licenses/>.

// (Этот файл — часть FreeTest.

//  FreeTest - свободная программа: вы можете перераспространять ее и/или
//  изменять ее на условиях Стандартной общественной лицензии GNU в том виде,
//  в каком она была опубликована Фондом свободного программного обеспечения;
//  либо версии 3 лицензии, либо (по вашему выбору) любой более поздней
//  версии.

//  FreeTest распространяется в надежде, что она будет полезной,
//  но БЕЗО ВСЯКИХ ГАРАНТИЙ; даже без неявной гарантии ТОВАРНОГО ВИДА
//  или ПРИГОДНОСТИ ДЛЯ ОПРЕДЕЛЕННЫХ ЦЕЛЕЙ. Подробнее см. в Стандартной
//  общественной лицензии GNU.

//  Вы должны были получить копию Стандартной общественной лицензии GNU
//  вместе с этой программой. Если это не так, см.
//  <http://www.gnu.org/licenses/>.)

unit Main;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, ExtCtrls,
  StdCtrls;

type

  { TMainForm }

  TMainForm = class(TForm)
    AboutBtn: TButton;
    OpenDialog: TOpenDialog;
    QuitBtn: TButton;
    EstablishBtn: TButton;
    OpenBtn: TButton;
    EstablishDialog: TSelectDirectoryDialog;
    TitleLabel: TLabel;
    LogoImg: TImage;
    procedure AboutBtnClick(Sender: TObject);
    procedure EstablishBtnClick(Sender: TObject);
    procedure QuitBtnClick(Sender: TObject);
    procedure OpenBtnClick(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  MainForm: TMainForm;
  dir, filename, path: string;

implementation

uses Establish, Open, About;

{$R *.lfm}

{ TMainForm }

procedure TMainForm.AboutBtnClick(Sender: TObject);
begin
  AboutForm.Show();
end;

procedure TMainForm.EstablishBtnClick(Sender: TObject);
var
  test: text;
begin
  if InputQuery('Создать', 'Введите название:', filename) then
  begin
    if EstablishDialog.Execute then
    begin
      dir := EstablishDialog.Filename;
      if FileExists(dir + '/' + filename + '.ftx') and (MessageDlg('Файл ' + filename +
      '.ftx уже существует!' + #13 + 'Заменить?', mtWarning, [mbYes, mbNo], 0)
      = mrYes) or not FileExists(dir + '/' + filename + '.ftx') then
      begin
        AssignFile(test, dir + '/' + filename + '.ftx');
        Rewrite(test);
        CloseFile(test);
        EstablishForm.Show();
        MainForm.Enabled := False;
      end;
    end;
  end;
end;

procedure TMainForm.QuitBtnClick(Sender: TObject);
begin
  Close();
  MainForm.Free;
  EstablishForm.Free;
  OpenForm.Free;
  AboutForm.Free;
end;

procedure TMainForm.OpenBtnClick(Sender: TObject);
begin
  if OpenDialog.Execute then
  begin
    path := OpenDialog.FileName;
    OpenForm.Show();
    MainForm.Enabled := False;
  end;
end;

{ TMainForm }

end.

