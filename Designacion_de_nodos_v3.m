

% Estime datos en nodos a modo de ejemplo, de forma que el codigo funcione
% en un ambiente controlado para verficar su efectividad en este punto al
% menos.
% Datos de los nodos (energía residual, calidad del enlace, distancia a BS, mensajes enviados y correctamente recibidos)
nodos = [
    0.7, 0.85, 15, 100, 80; % Nodo 1 (80 de 100 mensajes correctos, ajustado)
    0.7, 0.85, 12, 150, 120; % Nodo 2 (120 de 150 mensajes correctos)
    0.95, 0.95, 10, 200, 195; % Nodo 3 (195 de 200 mensajes correctos, ajustado)
    0.6, 0.95, 10, 120, 90;  % Nodo 4 (90 de 120 mensajes correctos)
];



% Pesos asignados, modificable dependiendo de las necesidades de la
% designacion
w1 = 0.4; % Peso para la energía residual
w2 = 0.3; % Peso para la calidad del enlace
w3 = 0.2; % Peso para la distancia a la BS
w4 = 0.1; % Peso para la probabilidad de fallo

% Número de nodos
num_nodos = size(nodos, 1);

% Inicializar vector para almacenar las probabilidades
P_coordinador = zeros(num_nodos, 1);

% Calcular P_coordinador para cada nodo
for i = 1:num_nodos
    E_residual = nodos(i, 1);
    Q_enlace = nodos(i, 2);
    D_BS = nodos(i, 3);
    mensajes_enviados = nodos(i, 4);
    mensajes_correctos = nodos(i, 5);
    
    % Calcular probabilidad de fallo: aqui preferi usar el parametro
    % anteriormente calculado en el algoritmo anterior como parametro para
    % probabilidad de fallos.
    
    if mensajes_enviados > 0
        P_fallo = 1 - (mensajes_correctos / mensajes_enviados);
    else
        P_fallo = 1; % Si no se enviaron mensajes, se asume fallo total
    end
    
    % Fórmula para P_coordinador
    P_coordinador(i) = w1 * E_residual + w2 * Q_enlace - w3 * D_BS - w4 * P_fallo;
    
    % Asegurar que P_coordinador esté dentro de [0, 1]
    if P_coordinador(i) < 0
        P_coordinador(i) = 0;
    elseif P_coordinador(i) > 1
        P_coordinador(i) = 1;
    end
end

% Encontrar el nodo con la mayor probabilidad
[valor_maximo, indice_maximo] = max(P_coordinador);

% Resultados: agregue un par de parametros en caso de necesitar evaluar
% listas de los nodos mas probables de ser maestros, aunque aun no es una
% idea en implementacion.

%en este apartado se mostraran otro posibles candidatos a nodo en caso de
%encontrar 2 nodos bajo exactamente las mismas condiciones, lo cual sera
%estadisiticamente casi imposible.

disp('Probabilidades de selección de los nodos:'); 
disp(P_coordinador);

disp('Nodo seleccionado como coordinador:');
fprintf('Nodo %d seleccionado como coordinador.\n', indice_maximo);

disp('Valor de probabilidad máxima:');
disp(valor_maximo);

