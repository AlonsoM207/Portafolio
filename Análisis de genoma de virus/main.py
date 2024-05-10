#Alonso Abimael Morales Reyna - A01284747
#Diego Alejandro Hernandez Romero A01198079
#Jose Eduardo Gomez Saldaña A00833968
#Melilssa Elvia Salazar Carrillo A01383422
#Santiago Andrés Gámez Campos A01197653
#Sergio Ortíz Malpica A01284951

#Archivo SARS-COV-2-MN908947.3 es la version del virus de 2019 mientras que el SARS-COV-2-MT106054.1 es la de 2020


# Algoritmo Knuth–Morris–Pratt para encontrar el índice en el que se encuentra un patrón en un texto
# input: un string texto y un string patron
# output: el índice en el que se puede encontrar el patron en el string texto
# complejidad temporal: O(n+m)
# complejidad temporal peor caso: O(n+m)
def KMP(patron, texto):
    twelve = ""
    # Lee el archivo del texto
    firstTexto = texto.readline() # Quitamos la primera línea con el nombre de la secuencia ya que no se utiliza para el análisis
    textoFile = texto.readlines()
    textoFile_str = ''.join(textoFile)
    textoFile_str = textoFile_str.replace('\n', '')

    # Lee el archivo del patron
    firstPatron = patron.readline() # Quitamos la primera línea con el nombre de la secuencia ya que no se utiliza para el análisis
    patronFile = patron.readlines()
    patronFile_str = ''.join(patronFile)
    patronFile_str = patronFile_str.replace('\n', '')

    # Encuentra los primeros 12 caracteres del gen
    for i in range (12):
        twelve += (patronFile_str[i])
    
    n = len(textoFile_str)
    m = len(patronFile_str)
    i = 0
    j = 0
    lps = [0]*m
    LPS(patronFile_str, m, lps)
    while i < n:
        # Cuando son iguales, los indices i y j avanzan
        if textoFile_str[i] == patronFile_str[j]:
            i += 1
            j += 1
        else:
            # Cuando no, j se reinicia con la longitud del lps
            if j > 0:
                j = lps[j-1]
            # Excepto si j = 0, entonces no hay lps previo y aumenta i
            else:
                i += 1
        # Si j alcanza a m, tenemos una coincidencia completa y reseteamos j para obtener todas las ocurrencias
        if j == m:
            print("El gen se encuentra en el índice", i-j+1 , "del virus SARS-COV-2 de Wuhan")
      
            print("Los primeros 12 caracteres del gen son:", twelve)
            j = lps[j-1]

# Inicializa la tabla Lowest Prefix Suffix (LPS)
def LPS(patronFile_str, m, lps):
    len = 0
    i = 1
    lps[0] = 0
    while i < m:
        if patronFile_str[i] == patronFile_str[len]:
            lps[i] = len + 1
            len += 1
            i += 1
        else:
            if len > 0:
                len = lps[len-1]
            else:
                lps[i] = 0
                i += 1

# El texto y el patron a utilizar
cov = open("SARS-COV-2-MN908947.3.txt", "r")
cov1 = open("SARS-COV-2-MN908947.3.txt", "r")
cov2 = open("SARS-COV-2-MN908947.3.txt", "r")
genM = open("gen-M.txt", "r")
genS = open("gen-S.txt", "r")
genORF = open("gen-ORF1AB.txt", "r")

print("1. Encontrar el índice de aparición de cada uno de los genes en la secuencia")
print("gen-M")
KMP(genM, cov)
print("")
print("gen-S")
KMP(genS, cov1)
print("")
print("gen-ORF1AB")
KMP(genORF, cov2)
print("")

# Algoritmo Manacher para encontrar palindromo mas largo de cada uno de
# los tres genes
# input: string de texto por gen
# output: palindromes mas grandes por gen


def Manacher(s):
  # Se procesa la  cadena s para simplificar la búsqueda de palíndormos  
  T = '#'.join('^{}$'.format(s)) # Inserta # entre cada cáracter en s y se agrega ^ al principio y $ al final
  n = len(T)
  #P[i] indica el radio del palíndromo centrado en el carácter T[i]
  P = [0] * n
  # C = centro del palíndromo derecho más grande encontrado hasta el momento
  # R = extremo derecho de ese palíndromo
  C, R = 0, 0

  for i in range(1, n-1):
    #Calcula la posición del mirror de i con respecto a C
     mirror = 2*C - i
     if R > i:
       #Se garantiza que no se superen los límites del palíndromo actual
       P[i] = min(R - i, P[mirror])
    #Intenta expandir el palíndromo centrado en i
     while T[i + 1 + P[i]] == T[i - 1 - P[i]]:
      P[i] += 1
    #Si el palíndromo centrado en i se expande más allá de R, se ajusta al centro y R
     if i + P[i] > R:
       C, R = i, i + P[i]
  #Encuentra el palíndromo más grande en P y extrae el índice central de ese palíndromo
  maxLen, centerIndex = max((n, i) for i, n in enumerate(P))
  #Calcula el inicio y el final del palíndromo en la cadena original s
  start = (centerIndex - maxLen) // 2
  end = start + maxLen
  #devuelve el palíndromo más largo
  return s[start:end]



#extrae las secuencias de los genes de los archivos y elimina los saltos de linea
genM = open("gen-M.txt", "r")
genS = open("gen-S.txt", "r")
genORF = open("gen-ORF1AB.txt", "r")

genM_content = genM.read().replace("\n", "")
genS_content = genS.read().replace("\n", "")
genORF_content = genORF.read().replace("\n", "")

#encuentra y muestra el palíndomo más largo en cada gen
print("\n2. Encontrar el palíndromo mas largo en cada uno de los tres genes")
print("El palíndromo más largo en el gen M es: ", Manacher(genM_content))
print("El palíndromo más largo en el gen S es: ", Manacher(genS_content))
print("El palíndromo más largo en el gen ORF1AB es: ", Manacher(genORF_content))

#Guarda el palindromo más largo y su longitud en un nuevo archivo
with open("palindromos_mas_largos.txt", "w") as file:
  file.write("Gen M: \nPalíndromo: " + Manacher(genM_content) + "\nLongitud: " + str(len(Manacher(genM_content))) + "\n\n")
  file.write("Gen S: \nPalíndromo: " + Manacher(genS_content) + "\nLongitud: " + str(len(Manacher(genS_content))) + "\n\n")
  file.write("Gen ORF1AB: \nPalíndromo: " + Manacher(genORF_content) + "\nLongitud: " + str(len(Manacher(genORF_content))) + "\n\n")

# Encontrar las secciones en que se produce cada proteina para los viruses
# Abre archivo de gen, convierte los codones a aminoacidos y lo busca en el archivo de
# secuencias de proteina y encuentra en que proteina esta
# Complejidad peor de los casos: O(n * m)

# Funcion auxiliar de Algoritmo Z
def findZ(search_str, z):
  n = len(search_str)

  # Crear variables de comparacion y rango
  l = k = r = 0
  # Loop para recorrer el string concatenado
  for i in range(1, n):
    # Para el caso donde no hay matches de substrings
    if i > r:
      l = r = i
      # Calcular Z[i]
      while r < n and search_str[r - l] == search_str[r]:
        r += 1
      z.append(r - l)
      r -= 1

    else:
      # K es el la posicion del numero de matches por posicion
      k = i - l
      # Checa si se puede copiar los previos
      if z[k] < r - i + 1:
        z.append(z[k])

      else:
        # Realiza una busqueda manual
        l = i
        while r < n and search_str[r - l] == search_str[r]:
          r += 1
        z.append(r - l)
        r -= 1


# Funcion con Algoritmo Z para buscar matches
def AlgZ(textoFile_str, patrn):
    # Dividir el archivo en líneas
    lineas = textoFile_str.split('\n')
    nombre_sequencia = ""

    # Loop para almacenar el nombre de la proteina
    for linea in lineas:
        if linea.startswith('>'):
          # Extraer el nombre de la secuencia sin el carácter '>'
          nombre_sequencia = linea[1:].strip()
  
        # String concatenado
        search_str = patrn + "$$" + textoFile_str
        lenght = len(search_str)
    
        # Construir array de Z
        z = [0] * 1
        findZ(search_str, z)
    
        # Loop para recorrer el array Z
        for i in range(lenght):
          # Si encuentra un match, obtiene la posicion donde esta
          if z[i] == len(patrn):
            # Imprimir el nombre de la proteina
            print("En sequencia: ")
            print(nombre_sequencia)
            # Imprime la posicion donde se encuentra la proteina
            print("Se produce en posicion: ")
            print(i - len(patrn) - 1)

def DNAtoProtein(textoFile_str1, lenght, textoFile_str):
    codon_to_aminoacid = {
        "A": ["GCT", "GCC", "GCA", "GCG"],
        "R": ["CGT", "CGC", "CGA", "CGG", "AGA", "AGG"],
        "N": ["AAT", "AAC"],
        "D": ["GAT", "GAC"],
        "B": ["AAT", "AAC", "GAT", "GAC"],
        "C": ["TGT", "TGC"],
        "Q": ["CAA", "CAG"],
        "E": ["GAA", "GAG"],
        "Z": ["CAA", "CAG", "GAA", "GAG"],
        "G": ["GGT", "GGC", "GGA", "GGG"],
        "H": ["CAT", "CAC"],
        "I": ["ATT", "ATC", "ATA"],
        "L": ["CTT", "CTC", "CTA", "CTG", "TTA", "TTG"],
        "K": ["AAA", "AAG"],
        "M": ["ATG"],
        "F": ["TTT", "TTC"],
        "P": ["CCT", "CCC", "CCA", "CCG"],
        "S": ["TCT", "TCC", "TCA", "TCG", "AGT", "AGC"],
        "T": ["ACT", "ACC", "ACA", "ACG"],
        "W": ["TGG"],
        "Y": ["TAT", "TAC"],
        "V": ["GTT", "GTC", "GTA", "GTG"]
    }

    codonInSequence = []
    aminoInSequence = ""
    temp = ""

    for j in range(0, lenght, 3):
        temp = textoFile_str1[j:j+3]
        found = False
        for aminoacid, codons in codon_to_aminoacid.items():
            if temp in codons:
                aminoInSequence += aminoacid
                codonInSequence.append(temp)  # Agregar el codón a la lista
                found = True
                break
        if not found:
            temp = ""  # Reiniciar temp si no se encuentra en el diccionario

    print("Secuencia de aminoácidos: ")
    print(aminoInSequence[0:6])
    print("Secuencia de codones por aminoácidos: ")
    print(codonInSequence[0:4])

    # Establecer el patron a buscar en algoritmo Z
    patrn = aminoInSequence[0:6]

    # Llamar funcion de algoritmo Z
    AlgZ(textoFile_str, patrn)

# Abrir archivos, leerlos y llamar la funcion para convertir de codones a aminoacidos
texto_1 = open("gen-M.txt", "r")
texto_1_file = texto_1.readlines()
textoFile_str1 = ''.join(texto_1_file)
len_textoFile1 = len(textoFile_str1)
texto_1.close()

texto = open("seq-proteins.txt", "r")
textoFile = texto.readlines()
textoFile_str = ''.join(textoFile)
texto.close()
print("")
print("3. Índice de ocurrencia de proteínas")
DNAtoProtein(textoFile_str1, len_textoFile1, textoFile_str)

def comparar_cadenas_con_aminoacidos(cadena1, cadena2, tabla_codones):
    indices_diferentes = []
    subcadenas_diferentes = []
    aminoacidos_cadena1 = []
    aminoacidos_cadena2 = []

    # Obtener la longitud mínima de ambas cadenas
    min_longitud = min(len(cadena1), len(cadena2))
    
    # Iterar de 3 en 3 caracteres hasta la longitud mínima (buscando diferencias en codones ya que la diferencia que existe es solo de un caracter)
    for i in range(0, min_longitud, 3):
        subcadena1 = cadena1[i:i+3]
        subcadena2 = cadena2[i:i+3]

        # asignamos los codones a  un aminoácido segun nuestra tabla
        aminoacido1 = tabla_codones.get(subcadena1, '?')  
        aminoacido2 = tabla_codones.get(subcadena2, '?')  

        aminoacidos_cadena1.append(aminoacido1)
        aminoacidos_cadena2.append(aminoacido2)
        
        # Comparar los aminoácidos
        if aminoacido1 != aminoacido2:
            indices_diferentes.append(i)
            subcadenas_diferentes.append((subcadena1, subcadena2))
    
    return indices_diferentes, subcadenas_diferentes, aminoacidos_cadena1, aminoacidos_cadena2

tabla_codones = {
    "TTT": "F", "TTC": "F", "TGT": "C", "TGC": "C",
    "TTA": "L", "TTG": "L", "CTT": "L", "CTC": "L",
    "CTA": "L", "CTG": "L", "TCT": "S", "TCC": "S",
    "TCA": "S", "TCG": "S", "CCT": "P", "CCC": "P",
    "CCA": "P", "CCG": "P", "ACT": "T", "ACC": "T",
    "ACA": "T", "ACG": "T", "GTT": "V", "GTC": "V",
    "GTA": "V", "GTG": "V", "GCT": "A", "GCC": "A",
    "GCA": "A", "GCG": "A", "TAT": "Y", "TAC": "Y",
    "TAA": "*", "TAG": "*", "CAT": "H", "CAC": "H",
    "CAA": "Q", "CAG": "Q", "AAT": "N", "AAC": "N",
    "AAA": "K", "AAG": "K", "GAT": "D", "GAC": "D",
    "GAA": "E", "GAG": "E", "TGT": "C", "TGC": "C",
    "TGA": "*", "TGG": "W", "CGT": "R", "CGC": "R",
    "CGA": "R", "CGG": "R", "AGT": "S", "AGC": "S",
    "AGA": "R", "AGG": "R", "ATT": "I", "ATC": "I",
    "ATA": "I", "ATG": "M", "GGT": "G", "GGC": "G",
    "GGA": "G", "GGG": "G"
}


cov1 = open("SARS-COV-2-MT106054.1.txt", "r")
cov2 = open("SARS-COV-2-MN908947.3.txt", "r")
FirstTexto = cov1.readline()
textoFile = cov1.readlines()
textoFile_str = ''.join(textoFile)
secuencia1 = textoFile_str.replace('\n', '')

FirstTexto2 = cov2.readline()
textoFile2 = cov2.readlines()
textoFile_str2 = ''.join(textoFile2)
secuencia2 = textoFile_str2.replace('\n', '')
indices_no_iguales, subcadenas_no_iguales, aminoacidos_cadena1, aminoacidos_cadena2 = comparar_cadenas_con_aminoacidos(secuencia1, secuencia2, tabla_codones)


print("")
print("4. Diferencias Wuhan 2019 vs Texas 2020:")
for indice, subcadenas in zip(indices_no_iguales, subcadenas_no_iguales):
    subcadena1, subcadena2 = subcadenas
    
    # Obtener aminoácidos para cada subcadena
    aminoacido1 = tabla_codones.get(subcadena1, '?')  # si no existe el aminoacido pondra un signo de interrogacion
    aminoacido2 = tabla_codones.get(subcadena2, '?')  
    
    print(f"Índice: {indice}, Codon en Wuhan 2019: {subcadena1} Aminoacido: {aminoacido1}, Codon en Texas 2020: {subcadena2} Aminoacido: {aminoacido2}")