import { Controller } from "@hotwired/stimulus"
import jsPDF from "jspdf"
import html2canvas from "html2canvas"

export default class extends Controller {
  static targets = [ "container" ]

  downloadPdf() {
    const memo = this.containerTarget
    html2canvas(memo).then(canvas => {
      const imgData = canvas.toDataURL('image/png')
      const pdf = new jsPDF('p', 'mm', 'a4')
      const pdfWidth = pdf.internal.pageSize.getWidth()
      const pdfHeight = (canvas.height * pdfWidth) / canvas.width
      pdf.addImage(imgData, 'PNG', 0, 0, pdfWidth, pdfHeight)
      pdf.save("memo.pdf")
    })
  }

  downloadJpg() {
    const memo = this.containerTarget
    html2canvas(memo).then(canvas => {
      const link = document.createElement('a')
      link.download = 'memo.jpg'
      link.href = canvas.toDataURL('image/jpeg')
      link.click()
    })
  }
}
