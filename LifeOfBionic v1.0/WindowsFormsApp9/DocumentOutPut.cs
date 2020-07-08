using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Word = Microsoft.Office.Interop.Word;
using Excel = Microsoft.Office.Interop.Excel;
using System.Windows.Forms;
using iTextSharp;
using iTextSharp.text;
using iTextSharp.text.pdf;
using System.IO;

namespace WindowsFormsApp9
{
    class DocumentOutPut
    {
        private static Word.Application winword = new Word.Application();  //СОздаём COM-объект Word
        private static object missing = System.Reflection.Missing.Value;
        //талон записи на прием
        public static void PrintWriteAppointment(int NumTalon, string FIO, string TypeWrite, string Snils, string DateDischarge)
        {
            //int NumTalon = 15;
            //string FIO = "Степаненко Виктор Петрович";
            //string TypeWrite = "г.Москва, ул.Стародубовская, д1, к5";
            //string Snils = "12593049283";
            //string DateDischarge = "2019-15-12 15:32";

            var document = new iTextSharp.text.Document();
            try
            {
                SaveFileDialog SBD = new SaveFileDialog();
                SBD.FileName = "Talon.pdf";
                SBD.ShowDialog();
                string s = SBD.FileName;

                FileStream FS = new FileStream(s, FileMode.Create);
                using (var writer = PdfWriter.GetInstance(document, FS))
                {
                    document.Open();

                    BaseFont baseFont = BaseFont.CreateFont(@"C:\Windows\Fonts\arial.ttf", BaseFont.IDENTITY_H, BaseFont.NOT_EMBEDDED);
                    iTextSharp.text.Font font = new iTextSharp.text.Font(baseFont, iTextSharp.text.Font.DEFAULTSIZE, iTextSharp.text.Font.NORMAL);
                    var paragraph = new Paragraph("Талон #" + NumTalon, font);
                    paragraph.SpacingBefore = 20;
                    paragraph.Font.Size = 20;
                    paragraph.IndentationLeft = 65;
                    paragraph.Alignment = iTextSharp.text.Element.ALIGN_CENTER;

                    var paragraph2 = new Paragraph("ФИО пациента: " + FIO, font);
                    paragraph2.SpacingBefore = 20;
                    paragraph2.Font.Size = 20;
                    paragraph2.IndentationLeft = 65;
                    paragraph2.Alignment = iTextSharp.text.Element.ALIGN_LEFT;


                    var paragraph3 = new Paragraph("Снилс: " + Snils, font);
                    paragraph3.SpacingBefore = 20;
                    paragraph3.Font.Size = 15;
                    paragraph3.IndentationLeft = 65;
                    paragraph3.Alignment = iTextSharp.text.Element.ALIGN_LEFT;

                    var paragraph4 = new Paragraph("Запись производилась: " + TypeWrite, font);
                    paragraph4.SpacingBefore = 20;
                    paragraph4.Font.Size = 15;
                    paragraph4.IndentationLeft = 65;
                    paragraph4.Alignment = iTextSharp.text.Element.ALIGN_LEFT;

                    var paragraph5 = new Paragraph("Время записи: " + DateDischarge, font);
                    paragraph5.SpacingBefore = 20;
                    paragraph5.Font.Size = 12;
                    paragraph5.IndentationLeft = 65;
                    paragraph5.Alignment = iTextSharp.text.Element.ALIGN_RIGHT;

                    document.Add(paragraph);
                    document.Add(paragraph2);
                    document.Add(paragraph3);
                    document.Add(paragraph4);
                    document.Add(paragraph5);
                    document.Close();
                    writer.Close();
                }

            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message);
            }
        }
        //выписка на работу
        public static void PrintWorkDischarge(string FIO, int numVip, string Naprav, string DateRojden, 
            string PassportInfo, string DiseaseInfo, string DatePostup, int SrokLech, string StatusLech, 
            string Vrach, string DateVIpiski)
        {
            //string FIO;
            //int numVip;
            //string Naprav;
            //string DateRojden;
            //string PassportInfo;
            //string DiseaseInfo;
            //string DatePostup;
            //int SrokLech;
            //string StatusLech;
            //string Vrach;
            //string DateVIpiski;
            winword.Visible = false;
            winword.Documents.Application.Caption = "Рабочая выписка"; //заголовок документа

            Word.Document wordDocVipiska = winword.Documents.Add(ref missing, ref missing, ref missing, ref missing);

            wordDocVipiska.Paragraphs.Add();
            Word.Paragraph Vipiska = wordDocVipiska.Paragraphs.Add();
            Vipiska.Range.Font.Name = "Times New Roman";
            Vipiska.Range.Font.Size = 25;
            Vipiska.Range.Font.Bold = 1;
            Vipiska.Range.Text = "Выписка # " + numVip;
            Vipiska.Range.Paragraphs.Alignment = Microsoft.Office.Interop.Word.WdParagraphAlignment.wdAlignParagraphCenter;

            wordDocVipiska.Paragraphs.Add();
            Word.Paragraph VipiskaType = wordDocVipiska.Paragraphs.Add();
            VipiskaType.Range.Font.Name = "Times New Roman";
            VipiskaType.Range.Font.Size = 20;
            VipiskaType.Range.Font.Bold = 1;
            VipiskaType.Range.Text = "Направление: " + Naprav;
            VipiskaType.Range.Paragraphs.Alignment = Microsoft.Office.Interop.Word.WdParagraphAlignment.wdAlignParagraphCenter;

            wordDocVipiska.Paragraphs.Add();
            Word.Paragraph Surname = wordDocVipiska.Paragraphs.Add();
            Surname.Range.Font.Name = "Times New Roman";
            Surname.Range.Font.Size = 14;
            Surname.Range.Text = "ФИО пациента: " + FIO;
            Surname.Range.Paragraphs.Alignment = Microsoft.Office.Interop.Word.WdParagraphAlignment.wdAlignParagraphLeft;

            wordDocVipiska.Paragraphs.Add();
            Word.Paragraph DateRojd = wordDocVipiska.Paragraphs.Add();
            DateRojd.Range.Font.Name = "Times New Roman";
            DateRojd.Range.Font.Size = 14;
            DateRojd.Range.Text = "Дата рождения: " + DateRojden;
            DateRojd.Range.Paragraphs.Alignment = Microsoft.Office.Interop.Word.WdParagraphAlignment.wdAlignParagraphLeft;

            wordDocVipiska.Paragraphs.Add();
            Word.Paragraph Passport = wordDocVipiska.Paragraphs.Add();
            Passport.Range.Font.Name = "Times New Roman";
            Passport.Range.Font.Size = 14;
            Passport.Range.Text = "Паспортные данные: " + PassportInfo;
            Passport.Range.Paragraphs.Alignment = Microsoft.Office.Interop.Word.WdParagraphAlignment.wdAlignParagraphLeft;

            wordDocVipiska.Paragraphs.Add();
            Word.Paragraph Disease = wordDocVipiska.Paragraphs.Add();
            Disease.Range.Font.Name = "Times New Roman";
            Disease.Range.Font.Size = 16;
            Disease.Range.Text = "Заболевание: " + DiseaseInfo;
            Disease.Range.Paragraphs.Alignment = Microsoft.Office.Interop.Word.WdParagraphAlignment.wdAlignParagraphCenter;

            wordDocVipiska.Paragraphs.Add();
            Word.Paragraph InfoDisease = wordDocVipiska.Paragraphs.Add();
            InfoDisease.Range.Font.Name = "Times New Roman";
            InfoDisease.Range.Font.Size = 14;
            InfoDisease.Range.Text = "Дата поступления: " + DatePostup + ", Срок лечения в стационаре: "
                + SrokLech + " суток," + " Статус лечения: " + StatusLech;
            InfoDisease.Range.Paragraphs.Alignment = Microsoft.Office.Interop.Word.WdParagraphAlignment.wdAlignParagraphLeft;

            wordDocVipiska.Paragraphs.Add();
            Word.Paragraph Doctor = wordDocVipiska.Paragraphs.Add();
            Doctor.Range.Font.Name = "Times New Roman";
            Doctor.Range.Font.Size = 12;
            Doctor.Range.Text = "Лечащий врач: " + Vrach;
            Doctor.Range.Paragraphs.Alignment = Microsoft.Office.Interop.Word.WdParagraphAlignment.wdAlignParagraphLeft;

            wordDocVipiska.Paragraphs.Add();
            Word.Paragraph DateOutDisease = wordDocVipiska.Paragraphs.Add();
            DateOutDisease.Range.Font.Name = "Times New Roman";
            DateOutDisease.Range.Font.Size = 12;
            DateOutDisease.Range.Text = "Подпись лечащего врача ___________ " + "                                             "
                + "Дата выписки: " + DateVIpiski;
            DateOutDisease.Range.Paragraphs.Alignment = Microsoft.Office.Interop.Word.WdParagraphAlignment.wdAlignParagraphRight;

            winword.Visible = true;
        }
        //Выписка в учебное заведение
        public static void PrintSchoolDischarge(string FIO, /*int numVip,*/ string Naprav, string DateRojden, 
            string DiseaseInfo, string DatePostup, int SrokLech, string StatusLech, string DateVIpiski)
        {
            //string FIO;
            //int numVip;
            //string Naprav;
            //string DateRojden;
            //string DiseaseInfo;
            //string DatePostup;
            //int SrokLech;
            //string StatusLech;
            //string DateVIpiski;
            winword.Visible = false;
            winword.Documents.Application.Caption = "Выписка в учебное заведение"; //заголовок документа

            Word.Document wordDocVipiska = winword.Documents.Add(ref missing, ref missing, ref missing, ref missing);

            //wordDocVipiska.Paragraphs.Add();
            //Word.Paragraph Vipiska = wordDocVipiska.Paragraphs.Add();
            //Vipiska.Range.Font.Name = "Times New Roman";
            //Vipiska.Range.Font.Size = 25;
            //Vipiska.Range.Font.Bold = 1;
            //Vipiska.Range.Text = "Выписка # " + numVip;
            //Vipiska.Range.Paragraphs.Alignment = Microsoft.Office.Interop.Word.WdParagraphAlignment.wdAlignParagraphCenter;

            wordDocVipiska.Paragraphs.Add();
            Word.Paragraph VipiskaType = wordDocVipiska.Paragraphs.Add();
            VipiskaType.Range.Font.Name = "Times New Roman";
            VipiskaType.Range.Font.Size = 20;
            VipiskaType.Range.Font.Bold = 1;
            VipiskaType.Range.Text = "Направление: " + Naprav;
            VipiskaType.Range.Paragraphs.Alignment = Microsoft.Office.Interop.Word.WdParagraphAlignment.wdAlignParagraphCenter;

            wordDocVipiska.Paragraphs.Add();
            Word.Paragraph Surname = wordDocVipiska.Paragraphs.Add();
            Surname.Range.Font.Name = "Times New Roman";
            Surname.Range.Font.Size = 14;
            Surname.Range.Text = "ФИО пациента: " + FIO;
            Surname.Range.Paragraphs.Alignment = Microsoft.Office.Interop.Word.WdParagraphAlignment.wdAlignParagraphLeft;

            wordDocVipiska.Paragraphs.Add();
            Word.Paragraph DateRojd = wordDocVipiska.Paragraphs.Add();
            DateRojd.Range.Font.Name = "Times New Roman";
            DateRojd.Range.Font.Size = 14;
            DateRojd.Range.Text = "Дата рождения: " + DateRojden;
            DateRojd.Range.Paragraphs.Alignment = Microsoft.Office.Interop.Word.WdParagraphAlignment.wdAlignParagraphLeft;

            wordDocVipiska.Paragraphs.Add();
            Word.Paragraph Disease = wordDocVipiska.Paragraphs.Add();
            Disease.Range.Font.Name = "Times New Roman";
            Disease.Range.Font.Size = 16;
            Disease.Range.Text = "Заболевание: " + DiseaseInfo;
            Disease.Range.Paragraphs.Alignment = Microsoft.Office.Interop.Word.WdParagraphAlignment.wdAlignParagraphCenter;

            wordDocVipiska.Paragraphs.Add();
            Word.Paragraph InfoDisease = wordDocVipiska.Paragraphs.Add();
            InfoDisease.Range.Font.Name = "Times New Roman";
            InfoDisease.Range.Font.Size = 14;
            InfoDisease.Range.Text = "Дата поступления: " + DatePostup + ", Срок лечения в стационаре: "
                + SrokLech + " суток," + " Статус лечения: " + StatusLech;
            InfoDisease.Range.Paragraphs.Alignment = Microsoft.Office.Interop.Word.WdParagraphAlignment.wdAlignParagraphLeft;

            wordDocVipiska.Paragraphs.Add();
            Word.Paragraph DateOutDisease = wordDocVipiska.Paragraphs.Add();
            DateOutDisease.Range.Font.Name = "Times New Roman";
            DateOutDisease.Range.Font.Size = 12;
            DateOutDisease.Range.Text = "Дата выписки: " + DateVIpiski;
            DateOutDisease.Range.Paragraphs.Alignment = Microsoft.Office.Interop.Word.WdParagraphAlignment.wdAlignParagraphRight;

            winword.Visible = true;
        }        
        //печать приёмки товара
        public static void PrintDelivery(string[,] Data)
        {
            //string[,] SM = new string[20, 9];
            ////заполнение массива цифрами
            //int k = 0;
            //for (int i = 0; i < SM.GetLength(0); i++)
            //    for (int j = 0; j < SM.GetLength(1); j++)
            //    {
            //        k++;
            //        SM[i, j] = k.ToString();
            //    }

            //Объявляем приложение
            Excel.Application excelApp = new Excel.Application();
            //Количество листов в рабочей книге
            excelApp.SheetsInNewWorkbook = 1;
            //Добавить рабочую книгу
            Excel.Workbook workBook = excelApp.Workbooks.Add(Type.Missing);
            //Отключить отображение окон с сообщениями
            excelApp.DisplayAlerts = false;
            //Получаем первый лист документа (счет начинается с 1)
            Excel.Worksheet sheet = (Excel.Worksheet)excelApp.Worksheets.get_Item(1);
            //Название листа (вкладки снизу)
            sheet.Name = "Приёмка медикаментов";


            //Ячейка с названием 
            Excel.Range range1 = sheet.get_Range("A1:I1");
            range1.Merge(Type.Missing);
            range1.Cells.Font.Name = "Tahoma";
            range1.Cells.HorizontalAlignment = Excel.Constants.xlCenter;
            range1.Cells.Font.Size = 15;
            range1.Borders.LineStyle = Excel.XlLineStyle.xlContinuous;

            //Ячейка производитель
            Excel.Range range2 = sheet.get_Range("A2:A2");
            range2.Merge(Type.Missing);
            range2.Columns.ColumnWidth = 17;
            range2.Cells.Font.Name = "Tahoma";
            range2.Cells.HorizontalAlignment = Excel.Constants.xlCenter;
            range2.Cells.Font.Size = 12;
            range2.Borders.LineStyle = Excel.XlLineStyle.xlContinuous;

            //Ячейка лекарства
            Excel.Range range3 = sheet.get_Range("B2:B2");
            range3.Merge(Type.Missing);
            range3.Columns.ColumnWidth = 15;
            range3.Cells.Font.Name = "Tahoma";
            range3.Cells.HorizontalAlignment = Excel.Constants.xlCenter;
            range3.Cells.Font.Size = 12;
            range3.Borders.LineStyle = Excel.XlLineStyle.xlContinuous;

            //Ячейка категории
            Excel.Range range4 = sheet.get_Range("C2:C2");
            range4.Merge(Type.Missing);
            range4.Columns.ColumnWidth = 12;
            range4.Cells.Font.Name = "Tahoma";
            range4.Cells.HorizontalAlignment = Excel.Constants.xlCenter;
            range4.Cells.Font.Size = 12;
            range4.Borders.LineStyle = Excel.XlLineStyle.xlContinuous;

            //Ячейка поступившего количества
            Excel.Range range5 = sheet.get_Range("D2:D2");
            range5.Merge(Type.Missing);
            range5.Columns.ColumnWidth = 13;
            range5.Cells.Font.Name = "Tahoma";
            range5.Cells.HorizontalAlignment = Excel.Constants.xlCenter;
            range5.Cells.Font.Size = 12;
            range5.Borders.LineStyle = Excel.XlLineStyle.xlContinuous;

            //Ячейка дата поставки
            Excel.Range range6 = sheet.get_Range("E2:E2");
            range6.Merge(Type.Missing);
            range6.Columns.ColumnWidth = 17;
            range6.Cells.Font.Name = "Tahoma";
            range6.Cells.HorizontalAlignment = Excel.Constants.xlCenter;
            range6.Cells.Font.Size = 12;
            range6.Borders.LineStyle = Excel.XlLineStyle.xlContinuous;

            //Ячейка сотрудника
            Excel.Range range7 = sheet.get_Range("F2:F2");
            range7.Merge(Type.Missing);
            range7.Columns.ColumnWidth = 30;
            range7.Cells.Font.Name = "Tahoma";
            range7.Cells.HorizontalAlignment = Excel.Constants.xlCenter;
            range7.Cells.Font.Size = 12;
            range7.Borders.LineStyle = Excel.XlLineStyle.xlContinuous;

            //Ячейка склада
            Excel.Range range8 = sheet.get_Range("G2:G2");
            range8.Merge(Type.Missing);
            range8.Columns.ColumnWidth = 16;
            range8.Cells.Font.Name = "Tahoma";
            range8.Cells.HorizontalAlignment = Excel.Constants.xlCenter;
            range8.Cells.Font.Size = 12;
            range8.Borders.LineStyle = Excel.XlLineStyle.xlContinuous;

            //Ячейка общего места на складе
            Excel.Range range9 = sheet.get_Range("H2:H2");
            range9.Merge(Type.Missing);
            range9.Columns.ColumnWidth = 14;
            range9.Cells.Font.Name = "Tahoma";
            range9.Cells.HorizontalAlignment = Excel.Constants.xlCenter;
            range9.Cells.Font.Size = 12;
            range9.Borders.LineStyle = Excel.XlLineStyle.xlContinuous;

            //Ячейка общего места на складе
            Excel.Range range10 = sheet.get_Range("I2:I2");
            range10.Merge(Type.Missing);
            range10.Columns.ColumnWidth = 15;
            range10.Cells.Font.Name = "Tahoma";
            range10.Cells.HorizontalAlignment = Excel.Constants.xlCenter;
            range10.Cells.Font.Size = 12;
            range10.Borders.LineStyle = Excel.XlLineStyle.xlContinuous;

            //Заполнение ячеек
            range1.Cells[1, 1] = String.Format("Поставки медикаментов");
            range2.Cells[1, 1] = String.Format("Производитель");
            range3.Cells[1, 1] = String.Format("Медикамент");
            range4.Cells[1, 1] = String.Format("Категория");
            range5.Cells[1, 1] = String.Format("Поступило");
            range6.Cells[1, 1] = String.Format("Дата поставки");
            range7.Cells[1, 1] = String.Format("Сотрудник");
            range8.Cells[1, 1] = String.Format("Ячейка склада");
            range9.Cells[1, 1] = String.Format("Места всего");
            range10.Cells[1, 1] = String.Format("Занято места");

            //Ячейка заполнения производителей
            Excel.Range range11 = sheet.get_Range("A3:I999");
            //range11.Columns.ColumnWidth = 15;
            range11.Cells.Font.Name = "Tahoma";
            range11.Cells.HorizontalAlignment = Excel.Constants.xlCenter;
            range11.Cells.Font.Size = 10;
            range11.Borders.LineStyle = Excel.XlLineStyle.xlContinuous;
            
            for (int i = 0; i < Data.GetLength(0); i++)
            {
                for (int j = 0; j < Data.GetLength(1); j++)
                {
                    range11.Cells[i+1, j+1] = Data[i,j];
                }
            }

            excelApp.Visible = true;
            excelApp.UserControl = true;
        }
        //Формирование отчёта со склада
        public static void PrintReportSup(string[,] SM)
        {
            //string[,] SM = new string[20, 4];
            ////заполнение массива цифрами
            //int k = 0;
            //for (int i = 0; i < SM.GetLength(0); i++)
            //    for (int j = 0; j < SM.GetLength(1); j++)
            //    {
            //        k++;
            //        SM[i, j] = k.ToString();
                //}

            //Объявляем приложение
            Excel.Application SostStorage = new Excel.Application();
            //Количество листов в рабочей книге
            SostStorage.SheetsInNewWorkbook = 1;
            //Добавить рабочую книгу
            Excel.Workbook workBook = SostStorage.Workbooks.Add(Type.Missing);
            //Отключить отображение окон с сообщениями
            SostStorage.DisplayAlerts = false;
            //Получаем первый лист документа (счет начинается с 1)
            Excel.Worksheet sheet = (Excel.Worksheet)SostStorage.Worksheets.get_Item(1);
            //Название листа (вкладки снизу)
            sheet.Name = "Складской отчёт";


            //Ячейка с названием 
            Excel.Range range1 = sheet.get_Range("A1:D1");
            range1.Merge(Type.Missing);
            range1.Cells.Font.Name = "Tahoma";
            range1.Cells.HorizontalAlignment = Excel.Constants.xlCenter;
            range1.Cells.Font.Size = 20;
            range1.Borders.LineStyle = Excel.XlLineStyle.xlContinuous;

            //Ячейка с номером ячейки склада
            Excel.Range range2 = sheet.get_Range("A2:A2");
            range2.Merge(Type.Missing);
            range2.Cells.Font.Name = "Tahoma";
            range1.Columns.ColumnWidth = 15;
            range2.Cells.HorizontalAlignment = Excel.Constants.xlCenter;
            range2.Cells.Font.Size = 15;
            range2.Borders.LineStyle = Excel.XlLineStyle.xlContinuous;

            //Всего места
            Excel.Range range3 = sheet.get_Range("B2:B2");
            range3.Merge(Type.Missing);
            range3.Cells.Font.Name = "Tahoma";
            range3.Cells.HorizontalAlignment = Excel.Constants.xlCenter;
            range1.Columns.ColumnWidth = 27;
            range3.Cells.Font.Size = 15;
            range3.Borders.LineStyle = Excel.XlLineStyle.xlContinuous;

            //Количества заполнено
            Excel.Range range4 = sheet.get_Range("C2:C2");
            range4.Merge(Type.Missing);
            range4.Cells.Font.Name = "Tahoma";
            range4.Cells.HorizontalAlignment = Excel.Constants.xlCenter;
            range1.Columns.ColumnWidth = 20;
            range4.Cells.Font.Size = 15;
            range4.Borders.LineStyle = Excel.XlLineStyle.xlContinuous;

            //Название медикамента
            Excel.Range range5 = sheet.get_Range("D2:D2");
            range5.Merge(Type.Missing);
            range5.Cells.Font.Name = "Tahoma";
            range5.Cells.HorizontalAlignment = Excel.Constants.xlCenter;
            range1.Columns.ColumnWidth = 33;
            range5.Cells.Font.Size = 15;
            range5.Borders.LineStyle = Excel.XlLineStyle.xlContinuous;

            range1.Cells[1, 1] = String.Format("Контроль склада");
            range2.Cells[1, 1] = String.Format("Номер ячейки");
            range3.Cells[1, 1] = String.Format("Места всего");
            range4.Cells[1, 1] = String.Format("Заполненное место");
            range5.Cells[1, 1] = String.Format("Название медикамента");

            //Ячейка заполнения производителей
            Excel.Range range11 = sheet.get_Range("A3:D999");
            range11.Cells.Font.Name = "Tahoma";
            range11.Cells.HorizontalAlignment = Excel.Constants.xlCenter;
            range11.Cells.Font.Size = 10;
            range11.Borders.LineStyle = Excel.XlLineStyle.xlContinuous;

            for (int i = 0; i < SM.GetLength(0); i++)
            {
                for (int j = 0; j < SM.GetLength(1); j++)
                {
                    range11.Cells[i + 1, j + 1] = SM[i, j];
                }
            }

            SostStorage.Visible = true;
            SostStorage.UserControl = true;
        }
        //статистика по палатам
        public static void PrintReportDeport(string[,] SM)
        {
            //string[,] SM = new string[20, 5];
            ////заполнение массива цифрами
            //int k = 0;
            //for (int i = 0; i < SM.GetLength(0); i++)
            //    for (int j = 0; j < SM.GetLength(1); j++)
            //    {
            //        k++;
            //        SM[i, j] = k.ToString();
            //    }

            //Объявляем приложение
            Excel.Application SostStorage = new Excel.Application();
            //Количество листов в рабочей книге
            SostStorage.SheetsInNewWorkbook = 1;
            //Добавить рабочую книгу
            Excel.Workbook workBook = SostStorage.Workbooks.Add(Type.Missing);
            //Отключить отображение окон с сообщениями
            SostStorage.DisplayAlerts = false;
            //Получаем первый лист документа (счет начинается с 1)
            Excel.Worksheet sheet = (Excel.Worksheet)SostStorage.Worksheets.get_Item(1);
            //Название листа (вкладки снизу)
            sheet.Name = "Приёмка медикаментов";

            //Ячейка с названием 
            Excel.Range range1 = sheet.get_Range("A1:E1");
            range1.Merge(Type.Missing);
            range1.Cells.Font.Name = "Tahoma";
            range1.Cells.HorizontalAlignment = Excel.Constants.xlCenter;
            range1.Cells.Font.Size = 20;
            range1.Borders.LineStyle = Excel.XlLineStyle.xlContinuous;

            //Ячейка с номером палаты
            Excel.Range range2 = sheet.get_Range("A2:A2");
            range2.Merge(Type.Missing);
            range2.Cells.Font.Name = "Tahoma";
            range2.Cells.HorizontalAlignment = Excel.Constants.xlCenter;
            range2.Cells.Font.Size = 14;
            range2.Columns.ColumnWidth = 19;
            range2.Borders.LineStyle = Excel.XlLineStyle.xlContinuous;

            //Ячейка с количеством мест в палате
            Excel.Range range3 = sheet.get_Range("B2:B2");
            range3.Merge(Type.Missing);
            range3.Cells.Font.Name = "Tahoma";
            range3.Cells.HorizontalAlignment = Excel.Constants.xlCenter;
            range3.Cells.Font.Size = 14;
            range3.Columns.ColumnWidth = 16;
            range3.Borders.LineStyle = Excel.XlLineStyle.xlContinuous;

            //Ячейка с занятыми местами в палате
            Excel.Range range4 = sheet.get_Range("C2:C2");
            range4.Merge(Type.Missing);
            range4.Cells.Font.Name = "Tahoma";
            range4.Cells.HorizontalAlignment = Excel.Constants.xlCenter;
            range4.Cells.Font.Size = 14;
            range4.Columns.ColumnWidth = 16;
            range4.Borders.LineStyle = Excel.XlLineStyle.xlContinuous;

            //Ячейка с названием категории заболевания
            Excel.Range range5 = sheet.get_Range("D2:D2");
            range5.Merge(Type.Missing);
            range5.Cells.Font.Name = "Tahoma";
            range5.Cells.HorizontalAlignment = Excel.Constants.xlCenter;
            range5.Cells.Font.Size = 14;
            range5.Columns.ColumnWidth = 36;
            range5.Borders.LineStyle = Excel.XlLineStyle.xlContinuous;

            //Ячейка с ФИО и специальность врача
            Excel.Range range6 = sheet.get_Range("E2:E2");
            range6.Merge(Type.Missing);
            range6.Cells.Font.Name = "Tahoma";
            range6.Cells.HorizontalAlignment = Excel.Constants.xlCenter;
            range6.Cells.Font.Size = 14;
            range6.Columns.ColumnWidth = 45;
            range6.Borders.LineStyle = Excel.XlLineStyle.xlContinuous;


            range1.Cells[1, 1] = String.Format("Статистика палат");
            range2.Cells[1, 1] = String.Format("Номер палаты");
            range3.Cells[1, 1] = String.Format("Кол-во мест");
            range4.Cells[1, 1] = String.Format("Занято мест");
            range5.Cells[1, 1] = String.Format("Категория заболеваний");
            range6.Cells[1, 1] = String.Format("ФИО, специальность врача");

            //Ячейка заполнения производителей
            Excel.Range range11 = sheet.get_Range("A3:E999");
            range11.Cells.Font.Name = "Tahoma";
            range11.Cells.HorizontalAlignment = Excel.Constants.xlCenter;
            range11.Cells.Font.Size = 10;
            range11.Borders.LineStyle = Excel.XlLineStyle.xlContinuous;

            for (int i = 0; i < SM.GetLength(0); i++)
            {
                for (int j = 0; j < SM.GetLength(1); j++)
                {
                    range11.Cells[i + 1, j + 1] = SM[i, j];
                }
            }

            SostStorage.Visible = true;
            SostStorage.UserControl = true;
        }
    }
}
