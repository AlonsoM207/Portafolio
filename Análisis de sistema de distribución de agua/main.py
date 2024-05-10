import matplotlib.pyplot as plt
from math import sqrt
import itertools

class Punto:

  def __init__(self, identificador, coordenada_x, coordenada_y, es_fuente):
    self.identificador = identificador
    self.coordenada_x = coordenada_x
    self.coordenada_y = coordenada_y
    self.es_fuente = es_fuente
    self.sector = None

  def __str__(self):
    return f"Nodo: {self.identificador}, Coordenadas: [{self.coordenada_x}, {self.coordenada_y}] fuente: {self.es_fuente}"


class Arista:

  def __init__(self, origen, destino, capacidad, longitud):
    self.origen = origen
    self.destino = destino
    self.capacidad = capacidad
    self.longitud = longitud

  def __str__(self):
    return f"Arista: {self.origen} -> {self.destino}, Capacidad: {self.capacidad}, Longitud: {self.longitud}"


class Sector:

  def __init__(self, fuente):
    self.fuente = fuente
    self.nodos = []
    self.nodo_mas_lejano = None
    self.distancia_maxima = 0

  def agregar_nodo(self, nodo):
    self.nodos.append(nodo)

    distancia_a_fuente = distancia(nodo, self.fuente)
    if distancia_a_fuente > self.distancia_maxima:
      self.distancia_maxima = distancia_a_fuente
      self.nodo_mas_lejano = nodo

  def imprimir_sector(self):
    if self.nodo_mas_lejano:
      print(f"Sector Fuente: {self.fuente.identificador}")
      print(
          f"Nodo más lejano: {self.nodo_mas_lejano.identificador} con distancia {self.distancia_maxima:.2f}"
      )
    else:
      print(
          f"Sector Fuente: {self.fuente.identificador} no tiene nodos asignados."
      )
  

    
def distancia(nodo1, nodo2):
  return sqrt((nodo1.coordenada_x - nodo2.coordenada_x)**2 +
              (nodo1.coordenada_y - nodo2.coordenada_y)**2)


# Una función para leer los archivos
def leer_archivo_grafo(nombre_archivo):
  nodos = {}
  aristas = []
  office = None
  nuevos = []

  with open(nombre_archivo, 'r') as archivo:
    lineas = archivo.readlines()

  cantidad_nodos, cantidad_aristas = map(int, lineas[0].split())

  # Leer nodos, aristas, office y nuevos
  leyendo_nodos = False
  leyendo_aristas = False
  leyendo_office = False
  leyendo_nuevos = False

  for linea in lineas[1:]:
    linea = linea.strip()

    if linea == "[NODES]":
      leyendo_nodos = True
      continue
    elif linea == "[EDGES]":
      leyendo_nodos = False
      leyendo_aristas = True
      continue
    elif linea == "[OFFICE]":
      leyendo_aristas = False
      leyendo_office = True
      continue
    elif linea == "[NEW]":
      leyendo_office = False
      leyendo_nuevos = True
      continue

    if leyendo_nodos:
      atributos = linea.split()
      identificador = int(atributos[0])
      coordenada_x = float(atributos[1])
      coordenada_y = float(atributos[2])
      es_fuente = bool(int(atributos[3]))
      nodos[identificador] = Punto(identificador, coordenada_x, coordenada_y,
                                   es_fuente)

    if leyendo_aristas:
      atributos = linea.split()
      origen = int(atributos[0])
      destino = int(atributos[1])
      capacidad = float(atributos[2])
      nodo_origen = nodos[origen]
      nodo_destino = nodos[destino]
      longitud = distancia(nodo_origen, nodo_destino)
      aristas.append(Arista(origen, destino, capacidad, longitud))

    if leyendo_office:
      office = int(linea)

    if leyendo_nuevos:
      nuevos.append(list(map(int, linea.split())))

  return nodos, aristas, office, nuevos


def imprimir_datos(nodos, aristas, office, nuevos):
  print("Nodos:")
  for nodo in nodos.values():
    print(nodo)

  print("\nAristas:")
  for arista in aristas:
    print(arista)

  print("\nOffice:", office)

  print("\nNuevos:")
  for item in nuevos:
    print(item)


###
def asignar_colores_sectores(sectores):
  colores = [
      "green", "yellow", "purple", "orange", "brown", "pink", "grey", "cyan"
  ]
  color_sector = {}
  for i, sector in enumerate(sectores):
    color_sector[sector.fuente.identificador] = colores[i % len(colores)]
  return color_sector


###
def graficar_grafo(nodos, aristas, color_sector=None):
  # Crear un nuevo gráfico
  plt.figure(figsize=(8, 8))

  for punto in nodos.values():
    # Verificar si el nodo tiene un sector y asignar color en consecuencia
    if punto.sector and punto.sector.fuente.identificador in color_sector:
      color = color_sector[punto.sector.fuente.identificador]
    elif punto.es_fuente:
      color = "red"
    else:
      color = "blue"

    plt.scatter(punto.coordenada_x, punto.coordenada_y, c=color, s=100)
    plt.text(punto.coordenada_x,
             punto.coordenada_y + 20,
             str(punto.identificador),
             fontsize=10,
             ha='center',
             color='black')

  # Dibujar aristas y etiquetas de capacidad
  for arista in aristas:
    nodo_origen = nodos[arista.origen]
    nodo_destino = nodos[arista.destino]
    x1, y1 = nodo_origen.coordenada_x, nodo_origen.coordenada_y
    x2, y2 = nodo_destino.coordenada_x, nodo_destino.coordenada_y
    plt.plot([x1, x2], [y1, y2], 'k-', lw=2)

    mitad_x = (x1 + x2) / 2
    mitad_y = (y1 + y2) / 2
    desplazamiento_x = (x2 - x1) / 20
    desplazamiento_y = (y2 - y1) / 20
    # Ajuste de posición para la etiqueta de capacidad
    plt.text(mitad_x + desplazamiento_x,
             mitad_y + desplazamiento_y,
             f' {arista.capacidad:.1f}',
             fontsize=8,
             ha='center',
             va='bottom',
             color='blue')
    # Ajuste de posición para la etiqueta de longitud
    plt.text(mitad_x - desplazamiento_x,
             mitad_y - desplazamiento_y,
             f' {arista.longitud:.1f}',
             fontsize=8,
             ha='center',
             va='top',
             color='green')

  # Agregar una caja de texto para la leyenda de la capacidad y la longitud
  texto_leyenda = "\nAzul - Capacidad\nVerde - Longitud"
  plt.text(0.05,
           0.05,
           texto_leyenda,
           transform=plt.gcf().transFigure,
           fontsize=10,
           verticalalignment='bottom',
           bbox=dict(boxstyle="round,pad=0.5",
                     facecolor="white",
                     edgecolor="black",
                     linewidth=1))
  # Configurar el gráfico
  plt.title("Grafo de Nodos y Aristas")

  # Mostrar el gráfico
  plt.show()

# Utilizamos el recorrido BFS (Breadth First Search) para recorrer un sector
def BFS(grafo, origen, destino, padre):
  queue = []
  visitado = [False]*len(grafo)
  queue.append(origen)
  visitado[origen] = True

  while queue:
    u = queue.pop(0)
    for i, val in enumerate(grafo):
      if visitado[i] == False and val > 0:
        queue.append(i)
        visitado[i] = True
        padre[i] = u
        if i == destino:
          return True
  return False

def max_flow(grafo, origen, destino):
  flujo = 0
  grafo = [i[:] for i in grafo]
  padre = [-1]*(len(grafo))
  while BFS(grafo, origen, destino, padre):
    path_flow = float("Inf")
    s = destino
    while s != origen:
      path_flow = min(path_flow, grafo[padre[s]][s])
      s = padre[s]
    flujo += path_flow
    des = destino
    while (des != origen):
      ori = padre[des]
      grafo[ori][des] -= path_flow
      grafo[des][ori] += path_flow
      des = padre[des]

  return flujo

# Crear y asignar sectores de fuentes a nodos
def asignar_sectores(nodos, aristas):
  print("\nAsignando sectores")
  sectores = [Sector(nodo) for nodo in nodos.values() if nodo.es_fuente]

  # Diccionario para mapear sectores a indices
  ind_sectores = {sector: i for i, sector in enumerate(sectores)}
  
  for nodo in nodos.values():
    if not nodo.es_fuente:
      sector_mas_cercano = min(
          sectores, key=lambda sector: distancia(nodo, sector.fuente))
      sector_mas_cercano.agregar_nodo(nodo)
      nodo.sector = sector_mas_cercano

  ### Imprimir la información de cada sector
  for sector in sectores:
    sector.imprimir_sector()

  # Determinar que nodos deben cerrarse
  aristas_cerradas = [
      arista for arista in aristas
      if not (nodos[arista.origen].es_fuente or nodos[arista.destino].es_fuente
              ) and nodos[arista.origen].sector != nodos[arista.destino].sector
  ]

  for i, sector in enumerate(sectores):
    print(f"Sector {i + 1}:")
    for nodo in sector.nodos:
      print(nodo)
    print()

  print("Aristas cerradas:")
  for arista in aristas_cerradas:
    print(arista)
  """
  # Generar matriz de capacidades
  num_sectores = len(sectores)
  capacidades = [[0 for _ in range(num_sectores)] for _ in range(num_sectores)]

  # Llenar matriz con capacidades de las aristas
  for arista in aristas:
      origen = nodos[arista.origen]
      destino = nodos[arista.destino]

      if origen is not None and destino is not None and origen != destino:
          print(origen)
          print(destino)
          capacidades[origen][destino] = arista.capacidad

  # Encontrar el flujo maximo por sector
  for sector_fuente in sectores:
    for sector_destino in sectores:
      if sector_fuente != sector_destino:
        flujo_maximo = max_flow(capacidades, sector_fuente, sector_destino)
        # Imprimir el flujo maximo
        print(f"El flujo maximo desde el sector {sector_fuente} al sector {sector_destino} es {flujo_maximo}")
"""


def vecino_mas_cercano(nodos, office):
    ruta = [office]  # Inicia en la oficina
    nodos_restantes = set(nodos.keys())
    nodos_restantes.remove(office)

    while nodos_restantes:
        nodo_actual = ruta[-1]
        nodo_cercano = min(nodos_restantes,
                           key=lambda n: distancia(nodos[nodo_actual], nodos[n]))
        ruta.append(nodo_cercano)
        nodos_restantes.remove(nodo_cercano)

    # Agrega la oficina al final para cerrar el ciclo
    ruta.append(office)

    return ruta


def encontrar_ruta_optima(nodos, aristas, office, nuevos, mostrar_grafico=True):
  print("\nEstado Inicial:")
  asignar_sectores(nodos, aristas)
  sectores = [Sector(nodo) for nodo in nodos.values() if nodo.es_fuente]
  color_sector = asignar_colores_sectores(sectores)
  graficar_grafo(nodos, aristas, color_sector)

  # Encuentra la ruta óptima usando el algoritmo del vecino más cercano
  ruta_optima = recorrido_optimo(nodos, office)
  print("\nRuta óptima antes de conectar nuevos nodos:", ruta_optima)

  # Calcula la distancia total de la ruta antes de conectar nuevos nodos
  distancia_total_antes = calcular_distancia_total(nodos, ruta_optima)
  print("Distancia total antes de conectar nuevos nodos:", distancia_total_antes)

  # Conectar nuevos nodos a la red y actualizar el estado
  aristas = conectar_nuevos_nodos(nodos, aristas, nuevos)

  print("\nEstado Después de Conectar Nuevos Nodos:")
  asignar_sectores(nodos, aristas)
  sectores = [Sector(nodo) for nodo in nodos.values() if nodo.es_fuente]
  color_sector = asignar_colores_sectores(sectores)
  graficar_grafo(nodos, aristas, color_sector)

  # Encuentra la nueva ruta óptima después de conectar nuevos nodos
  ruta_optima_despues = recorrido_optimo(nodos, office)
  print("\nRuta óptima después de conectar nuevos nodos:", ruta_optima_despues)

  # Calcula la distancia total de la nueva ruta
  distancia_total_despues = calcular_distancia_total(nodos, ruta_optima_despues)
  print("Distancia total después de conectar nuevos nodos:", distancia_total_despues)

  if mostrar_grafico:
      # Graficar la red después de conectar nuevos nodos
      plt.figure(figsize=(12, 6))
      plt.subplot(1, 2, 1)
      plt.title("Antes de Conectar Nuevos Nodos")
      graficar_grafo(nodos, aristas, color_sector)

      # Graficar la nueva ruta óptima
      plt.subplot(1, 2, 2)
      plt.title("Después de Conectar Nuevos Nodos")
      asignar_sectores(nodos, aristas)
      sectores_despues = [Sector(nodo) for nodo in nodos.values() if nodo.es_fuente]
      color_sector_despues = asignar_colores_sectores(sectores_despues)
      graficar_grafo(nodos, aristas, color_sector_despues)

      plt.show()




def recorrido_optimo(nodos, office):
    # Genera todas las posibles permutaciones de los nodos para encontrar la ruta óptima
    nodos_a_visitar = [nodo for nodo in nodos if nodo != office]
    permutaciones = itertools.permutations(nodos_a_visitar)

    # Inicializa la mejor ruta y su distancia total
    mejor_ruta = None
    mejor_distancia = float('inf')

    # Itera a través de todas las permutaciones
    for perm in permutaciones:
        # Construye la ruta considerando el nodo de la oficina (office) al principio y al final
        ruta_actual = [office] + list(perm) + [office]

        # Calcula la distancia total de la ruta actual
        distancia_actual = calcular_distancia_total(nodos, ruta_actual)

        # Actualiza la mejor ruta si la distancia actual es menor
        if distancia_actual < mejor_distancia:
            mejor_ruta = ruta_actual
            mejor_distancia = distancia_actual

    return mejor_ruta

def calcular_distancia_total(nodos, ruta):
  # Calcula la distancia total de la ruta
  distancia_total = sum(distancia(nodos[ruta[i]], nodos[ruta[i + 1]]) for i in range(len(ruta) - 1))
  return distancia_total

def conectar_nuevos_nodos(nodos, aristas, nuevos):
  for nuevo in nuevos:
      identificador_nuevo, coordenada_x, coordenada_y = nuevo
      nuevo_nodo = Punto(identificador_nuevo, coordenada_x, coordenada_y, False)
  
      # Enlazar el nuevo nodo al nodo más cercano que no sea fuente
      nodo_mas_cercano = min((nodo for nodo in nodos.values() if not nodo.es_fuente),
                             key=lambda nodo: distancia(nuevo_nodo, nodo))
  
      # Crear una nueva arista entre el nuevo nodo y el nodo más cercano
      nueva_arista = Arista(nodo_mas_cercano.identificador, identificador_nuevo,
                            capacidad=0, longitud=distancia(nuevo_nodo, nodo_mas_cercano))
      aristas.append(nueva_arista)
  
      # Actualizar el estado del nuevo nodo
      nodos[identificador_nuevo] = nuevo_nodo
      nuevo_nodo.sector = nodo_mas_cercano.sector
  
  return aristas

# Ejemplo de uso:
nodos, aristas, office, nuevos =leer_archivo_grafo("PES.txt")
imprimir_datos(nodos, aristas, office, nuevos)
encontrar_ruta_optima(nodos, aristas, office, nuevos)
asignar_sectores(nodos, aristas)
sectores = [Sector(nodo) for nodo in nodos.values() if nodo.es_fuente]
color_sector = asignar_colores_sectores(sectores)
graficar_grafo(nodos, aristas, color_sector)


"""
nodos, aristas, office, nuevos =leer_archivo_grafo("NYT.txt")
imprimir_datos(nodos, aristas, office, nuevos)
asignar_sectores(nodos, aristas)
sectores = [Sector(nodo) for nodo in nodos.values() if nodo.es_fuente]
color_sector = asignar_colores_sectores(sectores)
graficar_grafo(nodos, aristas, color_sector)

nodos, aristas, office, nuevos =leer_archivo_grafo("FOS.txt")
imprimir_datos(nodos, aristas, office, nuevos)
encontrar_ruta_optima(nodos, aristas, office, nuevos)
asignar_sectores(nodos, aristas)
sectores = [Sector(nodo) for nodo in nodos.values() if nodo.es_fuente]
color_sector = asignar_colores_sectores(sectores)
graficar_grafo(nodos, aristas, color_sector)

nodos, aristas, office, nuevos =leer_archivo_grafo("HAN.txt")
imprimir_datos(nodos, aristas, office, nuevos)
encontrar_ruta_optima(nodos, aristas, office, nuevos)
asignar_sectores(nodos, aristas)
sectores = [Sector(nodo) for nodo in nodos.values() if nodo.es_fuente]
color_sector = asignar_colores_sectores(sectores)
graficar_grafo(nodos, aristas, color_sector)
"""