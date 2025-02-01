module("modules.logic.balanceumbrella.config.BalanceUmbrellaConfig", package.seeall)

slot0 = class("BalanceUmbrellaConfig", BaseConfig)

function slot0.reqConfigNames(slot0)
	return {
		"balance_umbrella"
	}
end

slot0.instance = slot0.New()

return slot0
