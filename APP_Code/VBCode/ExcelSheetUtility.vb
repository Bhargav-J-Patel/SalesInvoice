Imports Microsoft.VisualBasic
Imports System.Data
Imports System.IO
Imports System.Web
Imports System.Web.UI
Imports System.Web.UI.WebControls
Imports iTextSharp.text
Imports iTextSharp.text.pdf
Imports iTextSharp.text.html
Imports iTextSharp.text.html.simpleparser
Imports System


Namespace ExcelUtility
    ''' <summary>
    ''' Summary description for functions
    ''' </summary>
    Public Class DataSetToExcel
        '
        ' TODO: Add constructor logic here
        '
        Public Sub New()
        End Sub

        Public Shared Sub Convert(ByVal ds As DataTable, ByVal filename As String)
            Dim response As HttpResponse = HttpContext.Current.Response

            ' first let's clean up the response.object
            response.Clear()
            response.Charset = ""

            ' set the response mime type for excel
            response.ContentType = "application/vnd.ms-excel"
            response.AddHeader("Content-Disposition", "attachment;filename=""" & filename & ".xls""")

            ' create a string writer
            Using sw As New StringWriter()
                Using htw As New HtmlTextWriter(sw)
                    ' instantiate a datagrid
                    Dim dg As New DataGrid()
                    dg.DataSource = ds
                    dg.DataBind()
                    dg.ShowHeader = False
                    dg.RenderControl(htw)
                    response.Write(sw.ToString())
                    response.[End]()
                End Using
            End Using

        End Sub

        Public Shared Sub ConvertHeadaer(ByVal ds As DataSet, ByVal filename As String)
            Dim response As HttpResponse = HttpContext.Current.Response

            ' first let's clean up the response.object
            response.Clear()
            response.Charset = ""

            ' set the response mime type for excel
            response.ContentType = "application/vnd.ms-excel"
            response.AddHeader("Content-Disposition", "attachment;filename=""" & filename & ".xls""")
            ' create a string writer
            Using sw As New StringWriter()
                Using htw As New HtmlTextWriter(sw)
                    ' instantiate a datagrid
                    Dim dg As New DataGrid()
                    dg.DataSource = ds.Tables(0)
                    dg.DataBind()
                    'dg.ShowHeader = False
                    dg.RenderControl(htw)
                    response.Write(sw.ToString())
                    response.[End]()
                End Using
            End Using
        End Sub

        Public Shared Sub ConvertHeadaerXLSB(ByVal ds As DataSet, ByVal filename As String)
            Dim response As HttpResponse = HttpContext.Current.Response

            ' first let's clean up the response.object
            response.Clear()
            response.Charset = ""

            ' set the response mime type for excel
            response.ContentType = "application/vnd.ms-excel.sheet.binary.macroEnabled.12"
            response.AddHeader("Content-Disposition", "attachment;filename=""" & filename & ".xls""")
            ' create a string writer
            Using sw As New StringWriter()
                Using htw As New HtmlTextWriter(sw)
                    ' instantiate a datagrid
                    Dim dg As New DataGrid()
                    dg.DataSource = ds.Tables(0)
                    dg.DataBind()
                    'dg.ShowHeader = False
                    dg.RenderControl(htw)
                    response.Write(sw.ToString())
                    response.[End]()
                End Using
            End Using
        End Sub
        Public Shared Sub ConvertPDF(ByVal ds As DataSet, ByVal filename As String)
            Dim response As HttpResponse = HttpContext.Current.Response

            ' first let's clean up the response.object
            response.Clear()
            response.Charset = ""

            'Dim doc As Document = New Document
            'PdfWriter.GetInstance(doc, New FileStream(filename + ".PDF", FileMode.Create))

            ' set the response mime type for excel
            response.ContentType = "application/pdf"
            response.AddHeader("Content-Disposition", "attachment;filename=""" & filename & ".pdf""")
            response.Cache.SetCacheability(HttpCacheability.NoCache)
            ' create a string writer


            Using sw As New StringWriter()
                Using htw As New HtmlTextWriter(sw)
                    'instantiate a datagrid
                    Dim dg As New DataGrid()
                    dg.DataSource = ds.Tables(0)
                    dg.DataBind()
                    dg.ShowHeader = False
                    dg.RenderControl(htw)
                    ''response.Write(sw.ToString())
                    'response.[End]()
                End Using
                ' Dim sw As New StringWriter()
                'Dim hw As New HtmlTextWriter(sw)
                Dim sr As New StringReader(sw.ToString())
                Dim pdfdoc As New Document(PageSize.A4, 10.0F, 10.0F, 10.0F, 0.0F)
                Dim htmlparser As New HTMLWorker(pdfdoc)

                PdfWriter.GetInstance(pdfdoc, response.OutputStream)
                pdfdoc.Open()
                htmlparser.Parse(sr)
                pdfdoc.Close()
                response.Write(pdfdoc)
                response.End()
            End Using
        End Sub
        Public Shared Sub ExportToCSV(ByVal DT As DataTable, ByVal tcFileName As String)
            Dim context As HttpContext = HttpContext.Current

            'Dim DT As New DataTable
            'DT = ds.Tables(0)


            context.Response.Clear()
            context.Response.ContentType = "text/csv"
            context.Response.AddHeader("Content-Disposition", "attachment; filename=" & tcFileName & "_" & Format(Date.Now(), "HHmm") & ".csv")
            'context.Response.Write("Relay Express Pvt. Ltd.")
            'context.Response.Write(Environment.NewLine)
            'context.Response.Write(Environment.NewLine)
            'context.Response.Write(Title)
            'context.Response.Write(Environment.NewLine)
            'context.Response.Write(Environment.NewLine)

            'rite column header names
            For i As Integer = 0 To DT.Columns.Count - 1
                If i > 0 Then
                    context.Response.Write(",")
                End If
                context.Response.Write(DT.Columns(i).ColumnName)
            Next
            context.Response.Write(Environment.NewLine)

            'Write data
            For Each row As DataRow In DT.Rows

                For i As Integer = 0 To DT.Columns.Count - 1
                    If i > 0 Then
                        context.Response.Write(",")
                    End If
                    context.Response.Write(row.ItemArray(i).ToString())
                Next
                context.Response.Write(Environment.NewLine)
            Next
            context.Response.[End]()
        End Sub
    End Class

End Namespace


Public Class ExcelSheetUtility

End Class
