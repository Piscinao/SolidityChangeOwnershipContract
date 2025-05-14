// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.8.2 <0.9.0;

/**
 * @title Storage
 * @dev Contrato de armazenamento com controle de propriedade e capacidade de receber Ether
 *
 * Conceitos importantes demonstrados:
 * 1. Persistência de Dados: Armazenamento permanente na blockchain
 * 2. Controle de Acesso: Padrão de propriedade e restrições
 * 3. Payable: Capacidade de receber Ether
 * 4. Visibilidade: Diferentes níveis de acesso às funções
 * 5. Gas Optimization: Uso de tipos otimizados
 */
contract Storage {
    // Variáveis de Estado (State Variables)
    // Armazenadas permanentemente no storage da blockchain
    uint256 number;  // Otimizado para números grandes (256 bits)
    address owner;   // Endereço Ethereum (160 bits)

    /**
     * @dev Modificador de Controle de Acesso
     * 
     * Conceitos demonstrados:
     * - Modificadores como padrão de segurança
     * - Controle de acesso baseado em endereço
     * - Uso de require para validações
     */
    modifier onlyOwner() {
        require(msg.sender == owner, "only owner");
        _; // Padrão de continuação do modificador
    }

    /**
     * @dev Constructor: Inicialização do Contrato
     * 
     * Conceitos demonstrados:
     * - Execução única na implantação
     * - msg.sender como identidade do deployer
     * - Inicialização de estado
     */
    constructor() {
        owner = msg.sender; // Atribuição atômica e permanente
    }

    /**
     * @dev Função de Armazenamento com Controle de Acesso
     * 
     * Conceitos demonstrados:
     * - Modificação de estado
     * - Controle de acesso
     * - Custos de gas para escrita
     * @param num valor a ser armazenado
     */
    function store(uint256 num) public onlyOwner {
        number = num; // Operação de escrita no storage (custosa em gas)
    }

    /**
     * @dev Transferência de Propriedade
     * 
     * Conceitos demonstrados:
     * - Mudança de controle
     * - Padrão de propriedade transferível
     * - Segurança na transferência
     */
    function changeOwner(address newOwner) public onlyOwner {
        owner = newOwner; // Atualização crítica de controle
    }

    /**
     * @dev Função para Receber Ether
     * 
     * Conceitos demonstrados:
     * - Payable functions
     * - Recebimento de Ether
     * - Contrato com saldo
     */
    function pay() public payable {
        // Função vazia mas payable permite receber Ether
    }

    /**
     * @dev Leitura de Dado Armazenado
     * 
     * Conceitos demonstrados:
     * - Função view (não modifica estado)
     * - Leitura de storage
     * - Gas optimization para leitura
     */
    function retrieve() public view returns (uint256) {
        return number; // Leitura do storage (menos custosa que escrita)
    }

    /**
     * @dev Consulta de Proprietário
     * 
     * Conceitos demonstrados:
     * - Transparência de propriedade
     * - Função view
     * - Acesso público a dados críticos
     */
    function getOwner() public view returns(address) {
        return owner;
    }

    /**
     * @dev Consulta de Saldo em Ether
     * 
     * Conceitos demonstrados:
     * - Acesso ao saldo do contrato
     * - this como referência ao contrato
     * - Conversão de unidades (wei para ether)
     */
    function getBalance() public view returns(uint256 bal) {
        bal = address(this).balance; // Saldo em wei
    }
}