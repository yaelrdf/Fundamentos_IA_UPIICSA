# Bibliotecas que se ocupan en la práctica
from sklearn import datasets                        # datos de ejemplo de scikit-learn
from sklearn.model_selection import train_test_split  # reparte datos en entrenamiento y prueba
from sklearn.svm import SVC                         # clasificador de vectores de soporte
from sklearn.metrics import classification_report, accuracy_score  # métricas
import matplotlib.pyplot as plt                     # para dibujar las imágenes

# Se carga el conjunto de dígitos escritos a mano (1797 imágenes de 8x8)
digits = datasets.load_digits()

# Se imprime el conjunto completo para ver los dígitos como arreglos
# (cada píxel va de 0 = sin trazo hasta 16 = trazo más oscuro)
print(digits)

# X guarda las imágenes y y guarda el número que representa cada una
X = digits.images   # entradas: valores de los píxeles de cada imagen
y = digits.target   # salidas: el dígito correcto (0 a 9)

# Se dibujan las primeras imágenes con su etiqueta
n_muestras = 5      # cantidad de imágenes en la fila

# Primera versión: escala de grises como en la guía
# (en 'gray' el fondo sale negro y el trazo sale blanco)
plt.figure(figsize=(10, 2))
for i in range(n_muestras):
    plt.subplot(1, n_muestras, i + 1)  # lugar de la imagen dentro de la fila
    plt.imshow(X[i], cmap='gray')      # se usa X[i] con corchetes
    plt.title(f"Dígito {y[i]}")        # la etiqueta va entre llaves
    plt.axis('off')                    # sin ejes para que se vea limpio
plt.show()

# Segunda versión: otros colores para que los números se distingan mejor
#   gray_r  -> grises invertidos: número oscuro sobre fondo blanco
#   viridis -> escala de morado a amarillo según la intensidad
#   inferno -> colores cálidos con mucho contraste
# vmin y vmax ponen la misma escala (0 a 16) en todas las imágenes
# bicubic suaviza los cuadritos de 8x8
mapas = [('gray_r', 'Gris invertido'), ('viridis', 'Viridis'), ('inferno', 'Inferno')]
fig, ejes = plt.subplots(len(mapas), n_muestras, figsize=(11, 7))
for fila, (cmap, nombre) in enumerate(mapas):
    for i in range(n_muestras):
        ax = ejes[fila, i]
        im = ax.imshow(X[i], cmap=cmap, vmin=0, vmax=16, interpolation='bicubic')
        ax.set_title(f"Dígito {y[i]}", fontsize=10)
        ax.axis('off')
    # texto vertical con el nombre de cada mapa de color
    ejes[fila, 0].text(-4.5, 3.5, nombre, rotation=90, va='center', ha='center',
                       fontsize=10, fontweight='bold')
    # barra lateral que relaciona cada color con su valor de intensidad
    fig.colorbar(im, ax=ejes[fila, :].tolist(), fraction=0.02, pad=0.02,
                 label="Intensidad (0-16)")
fig.suptitle("Visualización mejorada con distintos mapas de color", fontsize=12)
plt.show()

# El SVM necesita cada imagen como un renglón: 8x8 se vuelve 64 valores
X = X.reshape((X.shape[0], -1))

# 80 % de las imágenes para entrenar y 20 % para probar
# random_state=43 deja fija la división para obtener siempre lo mismo
X_train, X_test, y_train, y_test = train_test_split(
    X, y, test_size=0.2, random_state=43)

# Modelo SVM con kernel lineal
modelo = SVC(kernel='linear')

# Entrenamiento: el modelo aprende con las imágenes y sus etiquetas
modelo.fit(X_train, y_train)

# Predicción: el modelo clasifica las imágenes que no vio al entrenar
y_pred = modelo.predict(X_test)

# Precisión: proporción de predicciones que coinciden con la etiqueta real
precision = accuracy_score(y_test, y_pred)
# se usa {precision:.2f} para mostrar dos decimales
print(f"Precisión del modelo SVM con kernel lineal: {precision:.2f}")
print(f"Precisión con 4 decimales: {precision:.4f} "
      f"({int((y_test == y_pred).sum())} de {len(y_test)} aciertos)")
print()

# Reporte con precision, recall, f1-score y support de cada dígito
print("Informe de clasificación")
print(classification_report(y_test, y_pred))
