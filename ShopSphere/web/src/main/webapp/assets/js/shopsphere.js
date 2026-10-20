/**
 * ShopSphere Interactive E-Commerce Experience
 * Handles smooth scrolling, reveal animations, quantity steppers, toast notifications,
 * and review interactions.
 */

document.addEventListener("DOMContentLoaded", () => {
    // 1. Navbar Sticky & Scroll Effects
    const nav = document.querySelector(".shop-nav");
    const onScroll = () => {
        if (nav) {
            nav.classList.toggle("is-scrolled", window.scrollY > 15);
        }
    };
    onScroll();
    window.addEventListener("scroll", onScroll, { passive: true });

    // 2. Back to Top Button
    const backToTopBtn = document.getElementById("btnBackToTop");
    if (backToTopBtn) {
        window.addEventListener("scroll", () => {
            if (window.scrollY > 300) {
                backToTopBtn.classList.add("show");
            } else {
                backToTopBtn.classList.remove("show");
            }
        }, { passive: true });

        backToTopBtn.addEventListener("click", () => {
            window.scrollTo({ top: 0, behavior: "smooth" });
        });
    }

    // 3. Smooth Anchor Scrolling
    document.querySelectorAll('a[href^="#"]').forEach((link) => {
        link.addEventListener("click", (event) => {
            const hash = link.getAttribute("href");
            if (hash === "#") return;
            const target = document.querySelector(hash);
            if (target) {
                event.preventDefault();
                target.scrollIntoView({ behavior: "smooth", block: "start" });
            }
        });
    });

    // 4. Scroll Reveal Animations (IntersectionObserver)
    const revealElements = document.querySelectorAll(".reveal");
    if ("IntersectionObserver" in window) {
        const observer = new IntersectionObserver((entries, obs) => {
            entries.forEach((entry) => {
                if (entry.isIntersecting) {
                    entry.target.classList.add("is-revealed");
                    obs.unobserve(entry.target);
                }
            });
        }, {
            threshold: 0.1,
            rootMargin: "0px 0px -40px 0px"
        });

        revealElements.forEach((el) => observer.observe(el));
    } else {
        // Fallback for older browsers
        revealElements.forEach((el) => el.classList.add("is-revealed"));
    }

    // 5. Quantity Steppers
    document.querySelectorAll(".qty-stepper").forEach((stepper) => {
        const input = stepper.querySelector("input[type='number']");
        const btnMinus = stepper.querySelector(".btn-minus");
        const btnPlus = stepper.querySelector(".btn-plus");

        if (input && btnMinus && btnPlus) {
            btnMinus.addEventListener("click", () => {
                let val = parseInt(input.value, 10) || 1;
                const min = parseInt(input.min, 10) || 1;
                if (val > min) {
                    input.value = val - 1;
                    input.dispatchEvent(new Event("change"));
                }
            });

            btnPlus.addEventListener("click", () => {
                let val = parseInt(input.value, 10) || 1;
                const max = parseInt(input.max, 10) || 99;
                if (val < max) {
                    input.value = val + 1;
                    input.dispatchEvent(new Event("change"));
                }
            });
        }
    });

    // 6. Saved Address Clicker in Checkout
    document.querySelectorAll(".saved-address").forEach((button) => {
        button.addEventListener("click", () => {
            document.querySelectorAll(".saved-address").forEach((b) => b.classList.remove("border-primary", "bg-light"));
            button.classList.add("border-primary", "bg-light");

            const form = document.querySelector(".checkout-form");
            if (!form) return;

            const map = {
                label: "label",
                line1: "line1",
                line2: "line2",
                city: "city",
                state: "state",
                "postal-code": "postalCode",
                country: "country"
            };

            Object.entries(map).forEach(([dataKey, fieldName]) => {
                const camelKey = dataKey.replace(/-([a-z])/g, (_, letter) => letter.toUpperCase());
                const val = button.dataset[camelKey] || button.getAttribute("data-" + dataKey) || "";
                const field = form.elements.namedItem(fieldName);
                if (field) {
                    field.value = val;
                }
            });
        });
    });

    // 7. Interactive Review Star Rating
    const starContainer = document.querySelector(".star-rating-interactive");
    const ratingSelect = document.querySelector("select[name='rating']");
    if (starContainer && ratingSelect) {
        const stars = starContainer.querySelectorAll("i");
        const updateStars = (val) => {
            stars.forEach((star, index) => {
                if (index < val) {
                    star.className = "bi bi-star-fill text-warning";
                } else {
                    star.className = "bi bi-star text-muted";
                }
            });
        };

        stars.forEach((star) => {
            star.addEventListener("mouseenter", () => {
                const val = parseInt(star.getAttribute("data-value"), 10);
                updateStars(val);
            });
            star.addEventListener("click", () => {
                const val = parseInt(star.getAttribute("data-value"), 10);
                ratingSelect.value = val;
                updateStars(val);
            });
        });

        starContainer.addEventListener("mouseleave", () => {
            updateStars(parseInt(ratingSelect.value, 10) || 5);
        });

        ratingSelect.addEventListener("change", () => {
            updateStars(parseInt(ratingSelect.value, 10) || 5);
        });

        updateStars(parseInt(ratingSelect.value, 10) || 5);
    }

    // 8. Auto-dismissing Toasts after 5s
    const toasts = document.querySelectorAll(".toast.show");
    toasts.forEach((toastEl) => {
        setTimeout(() => {
            toastEl.classList.remove("show");
            setTimeout(() => toastEl.remove(), 400);
        }, 5000);
    });

    // 9. Quick Copy Coupon Code
    document.querySelectorAll(".btn-copy-coupon").forEach((btn) => {
        btn.addEventListener("click", () => {
            const code = btn.getAttribute("data-code");
            if (code && navigator.clipboard) {
                navigator.clipboard.writeText(code).then(() => {
                    const originalText = btn.innerHTML;
                    btn.innerHTML = '<i class="bi bi-check2"></i> Copied!';
                    setTimeout(() => { btn.innerHTML = originalText; }, 2000);
                });
            }
        });
    });
});
