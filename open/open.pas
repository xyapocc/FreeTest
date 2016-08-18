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

unit Open;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs,
  StdCtrls, ExtCtrls, XMLRead, DOM;

type

  { TOpenForm }

  TOpenForm = class(TForm)
    AnswerOpenEdit: TLabeledEdit;
    QuestionLabel: TLabel;
    ConitunueOpenBtn: TButton;
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormResize(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure ConitunueOpenBtnClick(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  OpenForm: TOpenForm;
  correct: integer;

implementation

uses Establish, Main;

{$R *.lfm}

{ TOpenForm }

procedure TOpenForm.FormShow(Sender: TObject);
begin
  correct := 0;
  count := 0;

  ReadXMLFile(xTest, path);
  cell := xTest.DocumentElement.FirstChild;
  QuestionLabel.Caption := Cypher(cell.ChildNodes.Item[0].FirstChild.NodeValue);
end;

procedure TOpenForm.ConitunueOpenBtnClick(Sender: TObject);
var
  _correct, _count: real;
begin
  inc(count);
  OpenForm.Caption := 'Вопрос №' + IntToStr(count + 1);
  if AnsiLowerCase(AnswerOpenEdit.Text) =
  AnsiLowerCase(Cypher(cell.ChildNodes.Item[1].FirstChild.NodeValue)) then
    inc(correct);
  cell := cell.NextSibling;
  if Assigned(cell) then
    QuestionLabel.Caption := Cypher(cell.ChildNodes.Item[0].FirstChild.NodeValue)
  else
  begin
    _correct := correct;
    _count := count;
    ShowMessage('Правильных ответов: ' + IntToStr(correct) + #13 +
    'Неправильных ответов: ' + IntToStr(count - correct) + #13 +
    'Процент правильных ответов: ' +
    FloatToStrF(_correct/_count * 100.0, ffGeneral, 3, 2) + '%');
    Close();
  end;
  AnswerOpenEdit.Clear();
end;

procedure TOpenForm.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
  xTest.Free;
  MainForm.Enabled := True;
end;

procedure TOpenForm.FormResize(Sender: TObject);
begin
  with QuestionLabel do
  begin
    Height := OpenForm.Height - 122;
    Width := OpenForm.Width - 16;
  end;
  with AnswerOpenEdit do
  begin
    Top := OpenForm.Height - 85;
    Width := OpenForm.Width - 16;
  end;
  with ConitunueOpenBtn do
  begin
    Left := OpenForm.Width - 139;
    Top := OpenForm.Height - 42;
  end;
end;

end.

