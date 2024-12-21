const dfd = require("danfojs-node");

// Função para ler arquivos JSON e retornar DataFrames
async function readJsons() {
    try {
        const vendas = await dfd.readJSON("data/broken_database_1.json");
        const marcas = await dfd.readJSON("data/broken_database_2.json");
        return { vendas, marcas };
    } catch (e) {
        console.error("Erro ao ler os arquivos JSON:", e);
    }
}

function fixNames(df, coluna) {
    try {
        df.addColumn(coluna, df[coluna].map(value => {
            return value
                .replace(/æ/g, 'a')  // Substitui 'æ' por 'a'
                .replace(/ø/g, 'o'); // Substitui 'ø' por 'o'
        }), {inplace: true});
        
        return df;
    } catch (e) {
        console.error("Erro ao corrigir os nomes:", e);
    }
}

function exportJsons(...dfs) {
    try {
        dfs.forEach((df, i) => {
        dfd.toJSON(df, {filePath: `fixed/fixed_database_${i+1}.json`})
        })
    } catch (e) {
        console.error("Erro ao salvar arquivos:", e)
    }
}

// Exemplo de uso
(async () => {
    const { vendas, marcas } = await readJsons();

    console.log("Marcas:");
    marcas.head().print();

    console.log("Vendas:");
    vendas.head().print();

    const marcasCorrigidas = fixNames(marcas, "marca");
    const vendasCorrigidas = fixNames(vendas, "nome");

    console.log("Vendas Corrigidas:");
    vendasCorrigidas.print();

    console.log("Marcas Corrigidas:");
    marcasCorrigidas.print();

    exportJsons(vendasCorrigidas, marcasCorrigidas)
})();
