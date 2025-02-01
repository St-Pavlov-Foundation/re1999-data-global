module("modules.logic.versionactivity1_2.jiexika.view.Activity114TimeView", package.seeall)

slot0 = class("Activity114TimeView", BaseView)

function slot0.onInitView(slot0)
	slot0._txtday = gohelper.findChildText(slot0.viewGO, "time/today/daytitle/#txt_day")
	slot0._txtdayen = gohelper.findChildText(slot0.viewGO, "time/today/daytitle/#txt_day/#txt_dayen")
	slot0._txtkeyDay = gohelper.findChildText(slot0.viewGO, "time/nextKeyDay/#txt_keyDay")
	slot0._goedubg = gohelper.findChild(slot0.viewGO, "time/today/eduTime/go_edubg")
	slot0._txteduTime = gohelper.findChildText(slot0.viewGO, "time/today/eduTime/#txt_eduTime")
	slot0._txteduTimeEn = gohelper.findChildText(slot0.viewGO, "time/today/eduTime/#txt_eduTime/txten")
	slot0._gofreebg = gohelper.findChild(slot0.viewGO, "time/today/freeTime/go_freebg")
	slot0._txtfreeTime = gohelper.findChildText(slot0.viewGO, "time/today/freeTime/#txt_freeTime")
	slot0._txtfreeTimeEn = gohelper.findChildText(slot0.viewGO, "time/today/freeTime/#txt_freeTime/txten")
	slot0._imageprocess = gohelper.findChildImage(slot0.viewGO, "time/today/round/bgline/#image_process")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	Activity114Controller.instance:registerCallback(Activity114Event.OnRoundUpdate, slot0.onRoundChange, slot0)
	slot0.viewContainer:registerCallback(Activity114Event.MainViewAnimBegin, slot0.onMainViewAnimBegin, slot0)
	slot0.viewContainer:registerCallback(Activity114Event.MainViewAnimEnd, slot0.onMainViewAnimEnd, slot0)
end

function slot0.removeEvents(slot0)
	Activity114Controller.instance:unregisterCallback(Activity114Event.OnRoundUpdate, slot0.onRoundChange, slot0)
	slot0.viewContainer:unregisterCallback(Activity114Event.MainViewAnimBegin, slot0.onMainViewAnimBegin, slot0)
	slot0.viewContainer:unregisterCallback(Activity114Event.MainViewAnimEnd, slot0.onMainViewAnimEnd, slot0)
end

function slot0._editableInitView(slot0)
	slot0.rounds = {}

	for slot4 = 1, 4 do
		slot0.rounds[slot4] = slot0:getUserDataTb_()
		slot0.rounds[slot4].type1 = gohelper.findChild(slot0.viewGO, "time/today/round/round" .. slot4 .. "/type1")
		slot0.rounds[slot4].type2 = gohelper.findChild(slot0.viewGO, "time/today/round/round" .. slot4 .. "/type2")
		slot0.rounds[slot4].type3 = gohelper.findChild(slot0.viewGO, "time/today/round/round" .. slot4 .. "/type3")
		slot0.rounds[slot4].actdesc = gohelper.findChildText(slot0.viewGO, "time/today/round/round" .. slot4 .. "/txt_actdesc")
	end

	slot0:onRoundChange()
end

function slot0.onMainViewAnimBegin(slot0)
	if not slot0.rounds[Activity114Model.instance.serverData.round - 1] then
		return
	end

	gohelper.setActive(slot0.rounds[slot1 - 1].type1, false)
end

function slot0.onMainViewAnimEnd(slot0)
	if not slot0.rounds[Activity114Model.instance.serverData.round - 1] then
		return
	end

	gohelper.setActive(slot0.rounds[slot1 - 1].type1, true)
	ZProj.ProjAnimatorPlayer.Get(slot0.rounds[slot1 - 1].type1):Play(UIAnimationName.Open)
end

function slot0.onRoundChange(slot0)
	slot1 = Activity114Model.instance.serverData.day

	if not Activity114Config.instance:getRoundCo(Activity114Model.instance.id, slot1, Activity114Model.instance.serverData.round) or not Activity114Config.instance:getKeyDayCo(Activity114Model.instance.id, slot1) or slot3.type == Activity114Enum.RoundType.KeyDay then
		return
	end

	for slot8 = 1, 4 do
		gohelper.setActive(slot0.rounds[slot8].type1, slot8 < slot2 and not Activity114Model.instance.isPlayingOpenAnim)
		gohelper.setActive(slot0.rounds[slot8].type2, slot8 == slot2)
		gohelper.setActive(slot0.rounds[slot8].type3, slot2 < slot8)

		slot0.rounds[slot8].actdesc.text = Activity114Config.instance:getRoundCo(Activity114Model.instance.id, slot1, slot8).desc

		SLFramework.UGUI.GuiHelper.SetColor(slot0.rounds[slot8].actdesc, slot8 == slot2 and "#B389D7" or "#CECECE")
	end

	slot0._imageprocess.fillAmount = (slot2 - 1) / 3
	slot0._txtday.text = formatLuaLang("versionactivity_1_2_114daydes", GameUtil.getNum2Chinese(slot1))
	slot0._txtdayen.text = "DAY " .. slot1
	slot0._txtkeyDay.text = GameUtil.getSubPlaceholderLuaLang(luaLang("versionactivity_1_2_114keydaydes"), {
		slot4.desc,
		slot4.day - slot1
	})

	gohelper.setActive(slot0._goedubg, slot3.type == Activity114Enum.RoundType.Edu)
	gohelper.setActive(slot0._gofreebg, slot3.type == Activity114Enum.RoundType.Free)

	slot0._txteduTime.alpha = slot3.type == Activity114Enum.RoundType.Edu and 1 or 0.102
	slot0._txteduTimeEn.alpha = slot3.type == Activity114Enum.RoundType.Edu and 0.2 or 0.051
	slot0._txtfreeTime.alpha = slot3.type == Activity114Enum.RoundType.Free and 1 or 0.102
	slot0._txtfreeTimeEn.alpha = slot3.type == Activity114Enum.RoundType.Free and 0.2 or 0.051
end

return slot0
