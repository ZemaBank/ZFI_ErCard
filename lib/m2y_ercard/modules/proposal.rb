module M2yErcard
  class Proposal < Base
    # POST /Proposta/IncluirPre
    def self.create_proposal(body)
      body[:strProduto] = product_code
      body[:strPontoAtendimento] = SHOP_CODE
      body[:strAtendente] = ATTENDANT_CODE
      body[:strBandeira] = FLAG_CODE
      post(base_url + PROPOSAL_PATH + CREATE_PROPOSAL_PATH, body)
    end

    # GET /Proposta/ConsultarSituacaoProposta
    def self.find_proposal_by_id(id)
      client_id = "/#{id}"
      get(base_url + PROPOSAL_PATH + FIND_PROPOSAL_BY_ID_PATH + client_id)
    end

    # GET /Proposta/ConsultarSituacaoPropostaCPF
    def self.find_proposal_by_cpf(cpf)
      get(base_url + PROPOSAL_PATH + FIND_PROPOSAL_BY_CPF_PATH, query: {strCliente: cpf, strTipoConsulta: "A"})
    end
  end
end
