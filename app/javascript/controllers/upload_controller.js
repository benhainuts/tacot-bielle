import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["input", "icon"]; // ✅ Ajoute "icon" pour qu'il soit reconnu

  // ✅ 1. Ouvrir le sélecteur de fichiers quand on clique sur l'icône
  selectFile() {
    this.inputTarget.click();
  }

  // ✅ 2. Prévisualisation de l'image après sélection
  previewImage(event) {
    const file = event.target.files[0]; // Récupère le fichier sélectionné
    if (!file) return;

    const reader = new FileReader();
    reader.onload = (e) => {
      let preview = document.getElementById("preview");
      let uploadIcon = this.iconTarget; // ✅ Récupère bien l'icône grâce à Stimulus

      preview.src = e.target.result;
      preview.style.display = "block"; // ✅ Affiche l’image

      // ✅ Cache l'icône sans casser le layout
      uploadIcon.style.opacity = "0";
      uploadIcon.style.pointerEvents = "none"; // Désactive le clic
    };
    reader.readAsDataURL(file);
  }
}
