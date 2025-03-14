import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["input", "icon", "preview"];

  // Ouvrir le sélecteur de fichiers quand on clique sur l'icône
  selectFile() {
    this.inputTarget.click();
  }

  // Prévisualisation de l'image après sélection
  previewImage(event) {
    const file = event.target.files[0];
    if (!file) return;

    const reader = new FileReader();
    reader.onload = (e) => {
      this.previewTarget.src = e.target.result;
      this.previewTarget.style.display = "block";
      this.iconTarget.style.opacity = "0";
      this.iconTarget.style.pointerEvents = "none";
    };
    reader.readAsDataURL(file);
  }
}
