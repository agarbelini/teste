from flask import Flask, render_template, request, redirect, url_for, flash
from flask_sqlalchemy import SQLAlchemy
from datetime import datetime

app = Flask(__name__)
app.secret_key = 'ccbeu@4812'
app.config['SQLALCHEMY_DATABASE_URI'] = 'mysql+pymysql://root:ccbeu%404812@localhost/planejamento'
app.config['SQLALCHEMY_TRACK_MODIFICATIONS'] = False

db = SQLAlchemy(app)

class Usuario(db.Model):
    id = db.Column(db.Integer, primary_key=True)
    nome = db.Column(db.String(100), nullable=False)
    email = db.Column(db.String(100), unique=True, nullable=False)
    perfil = db.Column(db.String(50), nullable=False)

class Projeto(db.Model):
    id = db.Column(db.Integer, primary_key=True)
    nome = db.Column(db.String(200), nullable=False)
    descricao = db.Column(db.Text)
    data_inicio = db.Column(db.Date, nullable=False)
    data_fim_planejada = db.Column(db.Date, nullable=False)
    data_fim_real = db.Column(db.Date)

class Atividade(db.Model):
    id = db.Column(db.Integer, primary_key=True)
    projeto_id = db.Column(db.Integer, db.ForeignKey('projeto.id'), nullable=False)
    titulo = db.Column(db.String(200), nullable=False)
    descricao = db.Column(db.Text)
    responsavel_id = db.Column(db.Integer, db.ForeignKey('usuario.id'))
    status = db.Column(db.String(50), default='Planejada')
    data_inicio_planejada = db.Column(db.Date, nullable=False)
    data_fim_planejada = db.Column(db.Date, nullable=False)
    data_inicio_real = db.Column(db.Date)
    data_fim_real = db.Column(db.Date)
    horas_planejadas = db.Column(db.Float)
    horas_gastas = db.Column(db.Float)

@app.route('/')
def index():
    projetos = Projeto.query.all()
    return render_template('index.html', projetos=projetos)

@app.route('/projeto/<int:id>')
def ver_projeto(id):
    projeto = Projeto.query.get_or_404(id)
    atividades = Atividade.query.filter_by(projeto_id=id).all()
    return render_template('projeto.html', projeto=projeto, atividades=atividades)

@app.route('/atividade/concluir/<int:id>')
def concluir_atividade(id):
    atividade = Atividade.query.get_or_404(id)
    atividade.status = 'Concluída'
    atividade.data_fim_real = datetime.today()
    db.session.commit()
    flash('Atividade concluída com sucesso!')
    return redirect(url_for('ver_projeto', id=atividade.projeto_id))

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5008, debug=True)
