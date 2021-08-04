module M2yErcard
  class Proposal < Base
    # POST /Proposta/IncluirPre
    def self.create_proposal(body)
      post(base_url + PROPOSAL_PATH + CREATE_PROPOSAL_PATH, body)
    end
  end
end