def app_port_run(app):
    """Run app finding free port."""
    import socket
    import webbrowser

    def find_free_port():
        with socket.socket(socket.AF_INET, socket.SOCK_STREAM) as s:
            s.bind(('', 0))
            return s.getsockname()[1]

    free_port = find_free_port()
    url = f"http://127.0.0.1:{free_port}"
    print(f"Running on {url}")
    
    # Open the app in the default web browser
    webbrowser.open(url)
    print(f"Running on port: {free_port}")
    app.run(host="127.0.0.1", port=free_port)

    return None

# app_port_run(app)