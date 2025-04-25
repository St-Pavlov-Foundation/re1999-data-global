module("modules.logic.versionactivity2_5.autochess.view.game.AutoChessResultView", package.seeall)

slot0 = class("AutoChessResultView", BaseView)

function slot0.onInitView(slot0)
	slot0._txtHp = gohelper.findChildText(slot0.viewGO, "Hp/#txt_Hp")
	slot0._txtDamage = gohelper.findChildText(slot0.viewGO, "Damage/#txt_Damage")
	slot0._txtTarDesc1 = gohelper.findChildText(slot0.viewGO, "Target/Target1/#txt_TarDesc1")
	slot0._goTarStar1 = gohelper.findChild(slot0.viewGO, "Target/Target1/start/#go_TarStar1")
	slot0._txtTarDesc2 = gohelper.findChildText(slot0.viewGO, "Target/Target2/#txt_TarDesc2")
	slot0._goTarStar2 = gohelper.findChild(slot0.viewGO, "Target/Target2/start/#go_TarStar2")
	slot0._txtTarDesc3 = gohelper.findChildText(slot0.viewGO, "Target/Target3/#txt_TarDesc3")
	slot0._goTarStar3 = gohelper.findChild(slot0.viewGO, "Target/Target3/start/#go_TarStar3")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
end

function slot0.removeEvents(slot0)
end

function slot0.onClickModalMask(slot0)
	slot0:closeThis()
end

function slot0._editableInitView(slot0)
end

function slot0.onUpdateParam(slot0)
end

function slot0.onOpen(slot0)
	AudioMgr.instance:setSwitch(AudioMgr.instance:getIdFromString("autochess"), AudioMgr.instance:getIdFromString("prepare"))
	AudioMgr.instance:trigger(AudioEnum.ChessGame.PlayerArrive)

	if AutoChessModel.instance.resultData then
		slot0._txtHp.text = slot3.remainingHp
		slot0._txtDamage.text = slot3.injury

		if lua_auto_chess_round.configDict[Activity182Model.instance:getCurActId()][AutoChessModel.instance:getChessMo().sceneRound] then
			for slot14 = 1, 3 do
				slot0["_txtTarDesc" .. slot14].text = GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("autochess_resultview_damage"), string.split(slot7.assess, "#")[slot14])

				gohelper.setActive(slot0["_goTarStar" .. slot14], slot14 <= slot3.star)
			end
		else
			logError(string.format("异常:不存在轮数配置actId:%sround:%s", slot5, slot6))
		end

		AutoChessController.instance:statFightEnd(tonumber(slot3.remainingHp))
	end
end

function slot0.onClose(slot0)
	AutoChessController.instance:onResultViewClose()
end

function slot0.onDestroyView(slot0)
end

return slot0
