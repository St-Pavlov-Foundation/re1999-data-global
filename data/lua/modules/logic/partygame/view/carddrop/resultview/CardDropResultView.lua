-- chunkname: @modules/logic/partygame/view/carddrop/resultview/CardDropResultView.lua

module("modules.logic.partygame.view.carddrop.resultview.CardDropResultView", package.seeall)

local CardDropResultView = class("CardDropResultView", BaseView)

function CardDropResultView:onOpen()
	local interface = PartyGameCSDefine.CardDropInterfaceCs
end

return CardDropResultView
