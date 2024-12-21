const { ChartJSNodeCanvas } = require("chartjs-node-canvas");
const fs = require("fs");

const width = 800; // Largura do gráfico
const height = 600; // Altura do gráfico
const chartJSNodeCanvas = new ChartJSNodeCanvas({
    type: "svg",
    width,
    height
});

const data = {
  labels: ["Rio", "São Paulo", "Belo Horizonte", "Salvador"],
  datasets: [
    {
      label: "População",
      data: [6748000, 12300000, 2520000, 2872000],
      //backgroundColor: ["#FF6384", "#36A2EB", "#FFCE56", "#4BC0C0"],
    },
  ],
};

const config = {
    type: "bar",
    data,
    options: {
      plugins: {
        title: {
          display: true,
          text: "População por Cidade",
        },
      },
      scales: {
        y: {
          beginAtZero: true,
        },
      },
      // Cor de fundo da área de plotagem
      layout: {
        padding: 20, // Ajuste o padding se necessário
      },
    },
  };
  

(async () => {
  // Garante que o fundo branco será aplicado corretamente
  const image = await chartJSNodeCanvas.renderToBuffer(config);
  fs.writeFileSync("populacao_por_cidade.png", image);
  console.log("Gráfico salvo como populacao_por_cidade.png com fundo branco");
})();
