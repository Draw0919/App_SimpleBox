from flask import Flask, request, render_template_string

app = Flask(__name__)

@app.route('/')
def index():
    user_input = request.args.get('data', '')
    # Deliberately vulnerable to XSS
    return render_template_string(f'<h1>Your input was: {user_input}</h1>')

if __name__ == '__main__':
    app.run(debug=True)
