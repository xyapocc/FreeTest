// Copyright © 2015-2016 Mikhailov Nikita Sergeevich
//   This file is part of FreeTest.

//   FreeTest is free software: you can redistribute it and/or modify
//   it under the terms of the GNU General Public LicenseImg as published by
//   the Free Software Foundation, either version 3 of the LicenseImg, or
//   (at your option) any later version.

//   FreeTest is distributed in the hope that it will be useful,
//   but WITHOUT ANY WARRANTY; without even the implied warranty of
//   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
//   GNU General Public LicenseImg for more details.

//   You should have received a copy of the GNU General Public LicenseImg
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

unit About;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, ExtCtrls,
  StdCtrls, LCLIntf;

type

  { TAboutForm }

  TAboutForm = class(TForm)
    OKBtn: TButton;
    SourceImg: TImage;
    AboutLabel: TLabel;
    LicenseImg: TImage;
    procedure LicenseImgClick(Sender: TObject);
    procedure SourceImgClick(Sender: TObject);
    procedure OKBtnClick(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  AboutForm: TAboutForm;

implementation

{$R *.lfm}

{ TAboutForm }

procedure TAboutForm.OKBtnClick(Sender: TObject);
begin
  Close();
end;

procedure TAboutForm.SourceImgClick(Sender: TObject);
begin
  OpenURL('https://github.com/erudite-individual/FreeTest');
end;

procedure TAboutForm.LicenseImgClick(Sender: TObject);
begin
  OpenURL('http://www.gnu.org/licenses/gpl-3.0.html');
end;

end.

