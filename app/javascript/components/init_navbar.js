const initNavbar = () => {
  const navbar = document.querySelector(".nav-transparent")
  if (navbar) {
    window.addEventListener('scroll', () => {
      if (window.scrollY >= window.innerHeight / 2) {
        navbar.classList.remove('nav-transparent');
      } else {
        navbar.classList.add('nav-transparent');
      }
    });
  }
}

export { initNavbar }
