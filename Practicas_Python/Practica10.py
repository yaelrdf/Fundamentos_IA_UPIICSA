# Importar las bibliotecas necesarias
from sklearn import datasets
from sklearn.model_selection import train_test_split
from sklearn.svm import SVC
from sklearn.metrics import classification_report, accuracy_score
import matplotlib.pyplot as plt

# Cargar el conjunto de datos de dígitos
digits = datasets.load_digits()

# Mostrar los dígitos en forma de arreglos
print(digits)

# Separar los datos en características (X) y etiquetas (y)
X = digits.images   # Características: las imágenes (intensidad de cada píxel)
y = digits.target   # Etiquetas: el dígito que representa cada imagen

# Visualizar una muestra de las imágenes y sus etiquetas
n_muestras = 5      # Número de imágenes que se mostrarán en una fila

# Versión original: escala de grises ('gray').
# El fondo (0) se ve negro y el trazo (16) se ve blanco.
plt.figure(figsize=(10, 2))
for i in range(n_muestras):
    plt.subplot(1, n_muestras, i + 1)      # 1 fila, 5 columnas, posición i+1
    plt.imshow(X[i], cmap='gray')
    plt.title(f"Dígito {y[i]}")
    plt.axis('off')                        # Oculta los ejes
plt.show()

#Mejora de la visualización: cambio de color y de grises

# Se muestran las mismas 5 imágenes con tres mapas de color:
#   'gray_r'  : gris invertido, trazo oscuro sobre fondo blanco (como en papel)
#   'viridis' : cada intensidad tiene un color distinto (de morado a amarillo)
#   'inferno' : alto contraste, resalta las zonas más intensas del trazo
# vmin=0 y vmax=16 fijan la misma escala para todas las imágenes.
# interpolation='bicubic' suaviza los cuadros de 8x8 para leer mejor el número.

mapas = [('gray_r', 'Gris invertido'), ('viridis', 'Viridis'), ('inferno', 'Inferno')]
fig, ejes = plt.subplots(len(mapas), n_muestras, figsize=(11, 7))
for fila, (cmap, nombre) in enumerate(mapas):
    for i in range(n_muestras):
        ax = ejes[fila, i]
        im = ax.imshow(X[i], cmap=cmap, vmin=0, vmax=16, interpolation='bicubic')
        ax.set_title(f"Dígito {y[i]}", fontsize=10)
        ax.axis('off')
    # Nombre del mapa de color a la izquierda de cada fila
    ejes[fila, 0].text(-4.5, 3.5, nombre, rotation=90, va='center', ha='center',
                       fontsize=10, fontweight='bold')
    # Barra de color: indica qué color corresponde a cada intensidad (0-16)
    fig.colorbar(im, ax=ejes[fila, :].tolist(), fraction=0.02, pad=0.02,
                 label="Intensidad (0-16)")
fig.suptitle("Visualización mejorada con distintos mapas de color", fontsize=12)
plt.show()

# Preprocesar las imágenes: de matriz 8x8 a vector de 64 valores
X = X.reshape((X.shape[0], -1))

# Dividir los datos: 80 % entrenamiento y 20 % prueba
# random_state=43 hace que la división sea siempre la misma (reproducible).
X_train, X_test, y_train, y_test = train_test_split(
    X, y, test_size=0.2, random_state=43)

# Crear el modelo SVM con kernel lineal
modelo = SVC(kernel='linear')

# Entrenar el modelo con los datos de entrenamiento
modelo.fit(X_train, y_train)    # El modelo aprende a partir de los ejemplos


# Predecir las etiquetas del conjunto de prueba
# El modelo indica qué dígito cree que es cada imagen nueva
y_pred = modelo.predict(X_test)

# Calcular la precisión del modelo
# accuracy_score compara las predicciones con las etiquetas reales
# y devuelve la proporción de aciertos (de 0 a 1).
precision = accuracy_score(y_test, y_pred)
# Corrección: el formato correcto es {precision:.2f} (dos decimales)
print(f"Precisión del modelo SVM con kernel lineal: {precision:.2f}")
print(f"Precisión con 4 decimales: {precision:.4f} "
      f"({int((y_test == y_pred).sum())} de {len(y_test)} aciertos)")
print()

#Mostrar un informe de clasificación con métricas detalladas
print("Informe de clasificación")
print(classification_report(y_test, y_pred))
