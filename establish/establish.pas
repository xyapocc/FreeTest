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

unit Establish;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, ExtCtrls,
  StdCtrls, XMLWrite, DOM;

function Cypher(UTF8Str: UTF8String): UTF8String;

type

  { TEstablishForm }

  TEstablishForm = class(TForm)
    ContinueBtn: TButton;
    CompleteBtn: TButton;
    QuestionEdit: TLabeledEdit;
    AnswerEdit: TLabeledEdit;
    procedure CompleteBtnClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure ContinueBtnClick(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  EstablishForm: TEstablishForm;
  xTest: TXMLDocument;
  root, cell, _cell: TDOMNode;
  count: integer;

implementation

uses Main;

{$R *.lfm}

{ TEstablishForm }

function Cypher(UTF8Str: UTF8String): UTF8String;
var
  str: string;
  i: integer;
const
  key = integer(2);
begin
  str := UTF8ToANSI(UTF8Str);
  for i := 1 to Length(str) do
    str[i] := chr(ord(str[i]) xor key);
  Cypher := ANSIToUTF8(str);
end;

procedure TEstablishForm.ContinueBtnClick(Sender: TObject);
begin
  root := xTest.DocumentElement;
  cell := xTest.CreateElement('task' + IntToStr(count));
  root.AppendChild(cell);

  cell := xTest.CreateElement('question');
  _cell := xTest.CreateTextNode(Cypher(QuestionEdit.Text));
  cell.AppendChild(_cell);
  root.ChildNodes.Item[count-1].AppendChild(cell);

  cell := xTest.CreateElement('answer');
  _cell := xTest.CreateTextNode(Cypher(AnswerEdit.Text));
  cell.AppendChild(_cell);
  root.ChildNodes.Item[count-1].AppendChild(cell);

  writeXMLFile(xTest, dir + '/' + filename + '.ftx');
  inc(count);
  EstablishForm.Caption := 'Вопрос №' + IntToStr(count);
  QuestionEdit.Clear();
  AnswerEdit.Clear();
end;

procedure TEstablishForm.FormShow(Sender: TObject);
begin
  count := 1;
  xTest := TXMLDocument.Create;
  root := xTest.CreateElement('test');
  xTest.AppendChild(root);
  writeXMLFile(xTest, dir + '/' + filename + '.ftx');
end;

procedure TEstablishForm.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
  xTest.Free;
  filename := '';
end;

procedure TEstablishForm.CompleteBtnClick(Sender: TObject);
begin
  if MessageDlg('Файл ' + filename + '.ftx' + ' успешно создан!', mtInformation,
  [mbOK], 0) = mrOK then
  begin
    Close();
    MainForm.Enabled := True;
  end;
end;

end.

