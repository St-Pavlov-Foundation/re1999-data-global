module("modules.logic.versionactivity1_2.trade.view.ActivityTradeSuccessView", package.seeall)

slot0 = class("ActivityTradeSuccessView", BaseView)

function slot0.onInitView(slot0)
	slot0._simagebg = gohelper.findChildSingleImage(slot0.viewGO, "root/#simage_bg")
	slot0._simageicon = gohelper.findChildSingleImage(slot0.viewGO, "root/main/iconbg/#simage_icon")
	slot0._txtaddcount = gohelper.findChildTextMesh(slot0.viewGO, "root/main/iconbg/#txt_addcount")
	slot0._txtname = gohelper.findChildTextMesh(slot0.viewGO, "root/main/#txt_name")
	slot0._txttotalget = gohelper.findChildTextMesh(slot0.viewGO, "root/main/bg/#txt_totalget")
	slot0._txtnextgoal = gohelper.findChildTextMesh(slot0.viewGO, "root/main/nextstage/#txt_nextgoal")
	slot0._gofinish = gohelper.findChild(slot0.viewGO, "root/main/nextstage/#txt_nextgoal/#go_finish")
	slot0._btnclose = gohelper.findChildClick(slot0.viewGO, "root/#btn_close")

	gohelper.setActive(slot0._gofinish, false)

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnclose:AddClickListener(slot0._onClickClose, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnclose:RemoveClickListener()
end

function slot0._editableInitView(slot0)
	slot0._simageicon:LoadImage(ResUrl.getVersionTradeBargainBg("icon/icon_tuerjiuchi"))

	slot0._txtname.text = luaLang("p_versionactivitytraderewardview_iconname")

	slot0._simagebg:LoadImage(ResUrl.getYaXianImage("img_huode_bg_2"))
end

function slot0.onDestroyView(slot0)
	slot0._simageicon:UnLoadImage()
	slot0._simagebg:UnLoadImage()
end

function slot0.onOpen(slot0)
	AudioMgr.instance:trigger(AudioEnum.UI.Task_UI_TaskItem_fadeout)
	slot0:updateView()
end

function slot0.onUpdateParam(slot0)
	slot0:updateView()
end

function slot0.updateView(slot0)
	slot0:refreshText(slot0.viewParam and slot0.viewParam.score or 0, slot0.viewParam and slot0.viewParam.curScore or 0, slot0.viewParam and slot0.viewParam.nextScore or 0)
end

function slot0.refreshText(slot0, slot1, slot2, slot3)
	slot0.score = slot1
	slot0.curScore = slot2
	slot0.nextScore = slot3
	slot0._txtaddcount.text = string.format("+%s", slot1)
	slot0._txtnextgoal.text = formatLuaLang("versionactivity_1_2_tradesuccessview_nextgoal", slot3)

	slot0:_refreshTotalget(true)
end

function slot0._refreshTotalget(slot0, slot1)
	if slot0._tweenId then
		ZProj.TweenHelper.KillById(slot0._tweenId)

		slot0._tweenId = nil
	end

	if slot1 then
		slot0._tweenId = ZProj.TweenHelper.DOTweenFloat(0, 1, 1, slot0._tweenFrameCallback, slot0._tweenFinishCallback, slot0)
	else
		slot0:_setTotal(slot0.curScore + slot0.score)
	end
end

function slot0._tweenFrameCallback(slot0, slot1)
	slot0:_setTotal(slot1 * slot0.score + slot0.curScore)
end

function slot0._tweenFinishCallback(slot0)
	slot0:_setTotal(slot0.curScore + slot0.score)
end

function slot0._setTotal(slot0, slot1)
	slot0._txttotalget.text = GameUtil.getSubPlaceholderLuaLang(luaLang("versionactivity_1_2_tradesuccessview_totalget"), {
		slot0.nextScore <= math.floor(slot1) and "#B9FF80" or "#D9A06F",
		slot2
	})

	gohelper.setActive(slot0._gofinish, slot0.nextScore <= slot2)
end

function slot0.onClose(slot0)
	if slot0._tweenId then
		ZProj.TweenHelper.KillById(slot0._tweenId)

		slot0._tweenId = nil
	end
end

function slot0._onClickClose(slot0)
	slot0:closeThis()
end

return slot0
