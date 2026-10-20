<%@ page contentType="text/html;charset=UTF-8" %>
<!doctype html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <title>Applet concept demo · ShopSphere</title>
    <link href="${pageContext.request.contextPath}/assets/css/shopsphere.css" rel="stylesheet">
    <style>
        body { max-width: 760px; margin: 3rem auto; padding: 0 1rem; }
        canvas { border-radius: 1rem; background: #10211c; display: block; width: 100%; height: 220px; }
        pre { background: #f4f1ea; padding: 1rem; border-radius: 0.8rem; overflow: auto; }
    </style>
</head>
<body>
<h1>Java Applets — historical demonstration</h1>
<p>Modern browsers no longer run the JVM plugin, so ShopSphere does not depend on applets.
This page records the syllabus concept and simulates a tiny canvas “applet” in JavaScript.</p>
<%-- Traditional applet markup is preserved only as a teaching artifact. --%>
<pre>&lt;applet code="ShopBannerApplet.class" width="480" height="160"&gt;
    &lt;param name="store" value="ShopSphere"/&gt;
&lt;/applet&gt;</pre>
<canvas id="legacy" width="640" height="220" aria-label="Animated banner replacing a Java applet"></canvas>
<p><a href="${pageContext.request.contextPath}/home">Return to ShopSphere</a></p>
<script>
    const canvas = document.getElementById("legacy");
    const ctx = canvas.getContext("2d");
    let t = 0;
    const draw = () => {
        t += 0.02;
        ctx.fillStyle = "#10211c";
        ctx.fillRect(0, 0, canvas.width, canvas.height);
        ctx.fillStyle = "#8ee0cc";
        ctx.beginPath();
        ctx.arc(140 + Math.sin(t) * 40, 110, 36, 0, Math.PI * 2);
        ctx.fill();
        ctx.fillStyle = "#fff";
        ctx.font = "28px Georgia";
        ctx.fillText("ShopSphere applet era → Swing + Servlets", 200, 120);
        requestAnimationFrame(draw);
    };
    draw();
</script>
</body>
</html>
