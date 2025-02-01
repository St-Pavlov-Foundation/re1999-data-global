module("modules.logic.meilanni.view.MeilanniTaskItem", package.seeall)

slot0 = class("MeilanniTaskItem", ListScrollCellExtend)

function slot0.onInitView(slot0)
	slot0._gonormal = gohelper.findChild(slot0.viewGO, "#go_normal")
	slot0._simagebg = gohelper.findChildSingleImage(slot0.viewGO, "#go_normal/#simage_bg")
	slot0._txttaskdes = gohelper.findChildText(slot0.viewGO, "#go_normal/#txt_taskdes")
	slot0._gorewards = gohelper.findChild(slot0.viewGO, "#go_normal/#go_rewards")
	slot0._gorewarditem = gohelper.findChild(slot0.viewGO, "#go_normal/#go_rewards/#go_rewarditem")
	slot0._gonotget = gohelper.findChild(slot0.viewGO, "#go_normal/#go_notget")
	slot0._btnnotfinishbg = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_normal/#go_notget/#btn_notfinishbg")
	slot0._btnfinishbg = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_normal/#go_notget/#btn_finishbg")
	slot0._goblackmask = gohelper.findChild(slot0.viewGO, "#go_normal/#go_blackmask")
	slot0._goget = gohelper.findChild(slot0.viewGO, "#go_normal/#go_get")
	slot0._imagelevelbg = gohelper.findChildImage(slot0.viewGO, "#go_normal/#image_levelbg")
	slot0._simagelevel = gohelper.findChildSingleImage(slot0.viewGO, "#go_normal/#simage_level")
	slot0._gogetall = gohelper.findChild(slot0.viewGO, "#go_getall")
	slot0._simagegetallbg = gohelper.findChildSingleImage(slot0.viewGO, "#go_getall/#simage_getallbg")
	slot0._btncollectall = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_getall/go_getall/#btn_collectall")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnnotfinishbg:AddClickListener(slot0._btnnotfinishbgOnClick, slot0)
	slot0._btnfinishbg:AddClickListener(slot0._btnfinishbgOnClick, slot0)
	slot0._btncollectall:AddClickListener(slot0._btncollectallOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnnotfinishbg:RemoveClickListener()
	slot0._btnfinishbg:RemoveClickListener()
	slot0._btncollectall:RemoveClickListener()
end

function slot0._btncollectallOnClick(slot0)
	slot0:_collect()
end

function slot0._btnnotfinishbgOnClick(slot0)
	if MeilanniMapItem.isLock(lua_activity108_map.configDict[slot0._mo.mapId]) then
		GameFacade.showToast(ToastEnum.MeilanniTask)

		return
	end

	MeilanniMapItem.gotoMap(slot1)
end

function slot0._btnfinishbgOnClick(slot0)
	slot0:_collect()
end

function slot0._collect(slot0)
	if slot0._mo.isGetAll then
		slot0.animatorPlayer = ZProj.ProjAnimatorPlayer.Get(slot0._gogetall)
	else
		slot0.animatorPlayer = ZProj.ProjAnimatorPlayer.Get(slot0._gonormal)
	end

	slot0._animator.speed = 1

	slot0.animatorPlayer:Play("finish", slot0.onFinishFirstPartAnimationDone, slot0)
end

function slot0.onFinishFirstPartAnimationDone(slot0)
	slot0._view.viewContainer.taskAnimRemoveItem:removeByIndex(slot0._index, slot0.onFinishSecondPartAnimationDone, slot0)
end

function slot0.onFinishSecondPartAnimationDone(slot0)
	Activity108Rpc.instance:sendGet108BonusRequest(MeilanniEnum.activityId, slot0._mo.id)
end

function slot0._editableInitView(slot0)
	slot0._rewardItems = slot0:getUserDataTb_()

	slot0._simagegetallbg:LoadImage(ResUrl.getMeilanniIcon("bg_rwdi_1"))
	slot0._simagebg:LoadImage(ResUrl.getMeilanniIcon("bg_rwdi_2"))
end

function slot0._editableAddEvents(slot0)
	gohelper.addUIClickAudio(slot0._btnnotfinishbg.gameObject, AudioEnum.Meilanni.play_ui_mln_move)
	gohelper.addUIClickAudio(slot0._btnfinishbg.gameObject, AudioEnum.Meilanni.play_ui_mln_receive)
	gohelper.addUIClickAudio(slot0._btncollectall.gameObject, AudioEnum.Meilanni.play_ui_mln_receive)
end

function slot0._editableRemoveEvents(slot0)
end

function slot0.onUpdateMO(slot0, slot1)
	slot0._mo = slot1
	slot0._canGet = false

	gohelper.setActive(slot0._gonormal, not slot1.isGetAll)
	gohelper.setActive(slot0._gogetall, slot1.isGetAll)

	if slot1.isGetAll then
		slot0._canGet = true
		slot0._animator = slot0._gogetall:GetComponent(typeof(UnityEngine.Animator))

		return
	end

	slot0._animator = slot0._gonormal:GetComponent(typeof(UnityEngine.Animator))
	slot0._txttaskdes.text = slot1.desc
	slot5 = slot2 and slot2:isGetReward(slot0._mo.id)

	gohelper.setActive(slot0._gonotget, not slot5)
	gohelper.setActive(slot0._goget, slot5)
	gohelper.setActive(slot0._goblackmask, slot5)

	if not slot5 then
		slot6 = slot1.score <= (MeilanniModel.instance:getMapInfo(slot1.mapId) and slot2:getMaxScore() or 0)

		gohelper.setActive(slot0._btnnotfinishbg.gameObject, not slot6)
		gohelper.setActive(slot0._btnfinishbg.gameObject, slot6)

		slot0._canGet = slot6
	end

	if slot5 or slot0._canGet then
		slot0._simagelevel:LoadImage(ResUrl.getMeilanniLangIcon("bg_jiangli_pingfen_" .. MeilanniConfig.instance:getScoreIndex(slot1.score)))
	else
		slot0._simagelevel:LoadImage(ResUrl.getMeilanniLangIcon("bg_jiangli_pingfen_" .. slot6 .. "_dis"))
	end

	slot0:_addRewards()
end

function slot0._addRewards(slot0)
	slot0._rewardItems = slot0._rewardItems or slot0:getUserDataTb_()

	for slot5 = 1, #string.split(slot0._mo.bonus, "|") do
		slot0:_showItem(slot5, string.splitToNumber(slot1[slot5], "#"))
	end
end

function slot0._showItem(slot0, slot1, slot2)
	if not slot0._rewardItems[slot1] then
		slot3 = {
			parentGo = gohelper.cloneInPlace(slot0._gorewarditem)
		}

		gohelper.setActive(slot3.parentGo, true)

		slot3.itemIcon = IconMgr.instance:getCommonPropItemIcon(slot3.parentGo)

		slot3.itemIcon:isShowCount(slot2[1] ~= MaterialEnum.MaterialType.Hero)
		slot3.itemIcon:showStackableNum2()
		slot3.itemIcon:setHideLvAndBreakFlag(true)
		slot3.itemIcon:hideEquipLvAndBreak(true)

		slot0._rewardItems[slot1] = slot3
	end

	slot3.itemIcon:setMOValue(slot2[1], slot2[2], slot2[3], nil, true)
	slot3.itemIcon:setCountFontSize(40)
end

function slot0.onSelect(slot0, slot1)
end

function slot0.onDestroyView(slot0)
	for slot4, slot5 in pairs(slot0._rewardItems) do
		gohelper.destroy(slot5.itemIcon.go)
		gohelper.destroy(slot5.parentGo)
		slot5.itemIcon:onDestroy()
	end

	slot0._rewardItems = nil

	slot0._simagebg:UnLoadImage()
	slot0._simagegetallbg:UnLoadImage()
end

function slot0.getAnimator(slot0)
	return slot0._animator
end

return slot0
