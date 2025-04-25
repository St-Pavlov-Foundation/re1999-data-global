module("modules.logic.versionactivity2_5.autochess.view.game.AutoChessMallLevelUpView", package.seeall)

slot0 = class("AutoChessMallLevelUpView", BaseView)

function slot0.onInitView(slot0)
	slot0._imageLevel1 = gohelper.findChildImage(slot0.viewGO, "icon/#image_Level1")
	slot0._txtMallLv1 = gohelper.findChildText(slot0.viewGO, "icon/#image_Level1/#txt_MallLv1")
	slot0._imageLevel2 = gohelper.findChildImage(slot0.viewGO, "icon/#image_Level2")
	slot0._txtMallLv2 = gohelper.findChildText(slot0.viewGO, "icon/#image_Level2/#txt_MallLv2")

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

function slot0.onOpen(slot0)
	AudioMgr.instance:trigger(AudioEnum.AutoChess.play_ui_tangren_store_upgrade)

	slot4 = lua_auto_chess_mall.configDict[AutoChessHelper.getMallRegionByType(AutoChessModel.instance:getChessMo().svrMall.regions, AutoChessEnum.MallType.Normal).mallId].showLevel
	slot5 = slot4 - 1

	UISpriteSetMgr.instance:setAutoChessSprite(slot0._imageLevel1, "v2a5_autochess_quality3_" .. slot5)
	UISpriteSetMgr.instance:setAutoChessSprite(slot0._imageLevel2, "v2a5_autochess_quality3_" .. slot4)

	slot6 = luaLang("autochess_malllevelupview_level")
	slot0._txtMallLv1.text = GameUtil.getSubPlaceholderLuaLangOneParam(slot6, slot5)
	slot0._txtMallLv2.text = GameUtil.getSubPlaceholderLuaLangOneParam(slot6, slot4)

	TaskDispatcher.runDelay(slot0.onClickModalMask, slot0, 2)
end

return slot0
