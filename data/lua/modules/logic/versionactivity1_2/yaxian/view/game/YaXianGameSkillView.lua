module("modules.logic.versionactivity1_2.yaxian.view.game.YaXianGameSkillView", package.seeall)

slot0 = class("YaXianGameSkillView", BaseView)

function slot0.onInitView(slot0)
	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
end

function slot0.removeEvents(slot0)
end

function slot0.onClickSkillBtn(slot0)
	AudioMgr.instance:trigger(AudioEnum.UI.UI_checkpoint_resources_rebound)
	slot0:changeSkillDescContainerVisible()
end

function slot0.onBlockClick(slot0)
	AudioMgr.instance:trigger(AudioEnum.UI.UI_Common_Click)
	slot0:changeSkillDescContainerVisible()
end

function slot0._editableInitView(slot0)
	slot0.goSkillBlock = gohelper.findChild(slot0.viewGO, "root/#go_skillblock")
	slot0.blockClick = gohelper.getClick(slot0.goSkillBlock)

	slot0.blockClick:AddClickListener(slot0.onBlockClick, slot0)

	slot0.goSkillContainer = gohelper.findChild(slot0.viewGO, "root/bottomleft")
	slot0.goSkillDescContent = gohelper.findChild(slot0.goSkillContainer, "skillDescContent")

	gohelper.setActive(slot0.goSkillDescContent, false)

	slot0.showSkillDescContainer = false
	slot0.goSkillDescItem1 = gohelper.findChild(slot0.goSkillContainer, "skillDescContent/#go_skillDescItem1")
	slot0.goSkillDescItem2 = gohelper.findChild(slot0.goSkillContainer, "skillDescContent/#go_skillDescItem2")
	slot0.goSkillItem1 = gohelper.findChild(slot0.goSkillContainer, "#go_simple/skillContent/skill1")
	slot0.goSkillItem2 = gohelper.findChild(slot0.goSkillContainer, "#go_simple/skillContent/skill2")
	slot0.skillBtn = gohelper.findChildClickWithAudio(slot0.goSkillContainer, "#go_simple/clickarea")

	slot0.skillBtn:AddClickListener(slot0.onClickSkillBtn, slot0)
	gohelper.setActive(slot0.goSkillDescContent, false)
	slot0:addEventCb(YaXianGameController.instance, YaXianEvent.OnUpdateSkillInfo, slot0.onUpdateSkillInfo, slot0)
end

function slot0.initSkillDescItem(slot0, slot1, slot2)
	slot3 = slot0:getUserDataTb_()
	slot3.goContainer = slot1
	slot3.txtDesc = gohelper.findChildText(slot1, "desc")
	slot3.goCantUse = gohelper.findChild(slot1, "skill/cantuse")
	slot3.goCanUse = gohelper.findChild(slot1, "skill/canuse")
	slot3.skillId = slot2
	slot3.animator = gohelper.findChild(slot1, "skill"):GetComponent(typeof(UnityEngine.Animator))
	slot3.click = gohelper.getClick(slot1)

	slot3.click:AddClickListener(slot0.onClickSkillItem, slot0, slot3)

	return slot3
end

function slot0.initSkillItem(slot0, slot1, slot2)
	slot3 = slot0:getUserDataTb_()
	slot3.goContainer = slot1
	slot3.imgicon = gohelper.findChildImage(slot1, "icon")
	slot3.goCantUse = gohelper.findChild(slot1, "cantuse")
	slot3.goCanUse = gohelper.findChild(slot1, "canuse")
	slot3.skillId = slot2
	slot3.animator = slot1:GetComponent(typeof(UnityEngine.Animator))

	return slot3
end

function slot0.onClickSkillItem(slot0, slot1)
	if not YaXianGameModel.instance:getSkillMo(slot1.skillId) then
		return
	end

	if slot2.canUseCount <= 0 then
		return
	end

	if slot2.id == YaXianGameEnum.SkillId.InVisible then
		AudioMgr.instance:trigger(AudioEnum.YaXian.InVisible)
	end

	Activity115Rpc.instance:sendAct115UseSkillRequest(slot2.actId, slot2.id)
	slot0:changeSkillDescContainerVisible()
end

function slot0.onUpdateParam(slot0)
	slot0:refreshUI()
end

function slot0.onOpen(slot0)
	gohelper.setActive(slot0.goSkillBlock, false)

	slot0.hideSkillDescItem = slot0:initSkillDescItem(slot0.goSkillDescItem1, YaXianGameEnum.SkillId.InVisible)
	slot0.throughSkillDescItem = slot0:initSkillDescItem(slot0.goSkillDescItem2, YaXianGameEnum.SkillId.ThroughWall)
	slot0.hideSkillItem = slot0:initSkillItem(slot0.goSkillItem1, YaXianGameEnum.SkillId.InVisible)
	slot0.throughSkillItem = slot0:initSkillItem(slot0.goSkillItem2, YaXianGameEnum.SkillId.ThroughWall)
	slot0.hideSkillDescItem.txtDesc.text = YaXianConfig.instance:getSkillConfig(YaXianEnum.ActivityId, YaXianGameEnum.SkillId.InVisible).desc
	slot0.throughSkillDescItem.txtDesc.text = YaXianConfig.instance:getSkillConfig(YaXianEnum.ActivityId, YaXianGameEnum.SkillId.ThroughWall).desc

	if YaXianGameModel.instance:hasSkill() then
		AudioMgr.instance:trigger(AudioEnum.RewardPoint.play_ui_track_achievement_single)
	end

	slot0:refreshUI()
end

function slot0.refreshUI(slot0)
	slot1 = YaXianGameModel.instance:hasSkill()

	gohelper.setActive(slot0.goSkillContainer, slot1)

	if not slot1 then
		return
	end

	slot0:refreshSkillDescItem(slot0.hideSkillDescItem)
	slot0:refreshSkillDescItem(slot0.throughSkillDescItem)
	slot0:refreshSkillItem(slot0.hideSkillItem)
	slot0:refreshSkillItem(slot0.throughSkillItem)
end

function slot0.refreshSkillDescItem(slot0, slot1)
	if not YaXianGameModel.instance:getSkillMo(slot1.skillId) then
		gohelper.setActive(slot1.goContainer, false)

		return
	end

	gohelper.setActive(slot1.goContainer, true)
	gohelper.setActive(slot1.goCanUse, slot2.canUseCount > 0)
	gohelper.setActive(slot1.goCantUse, slot2.canUseCount <= 0)
	slot0:playDescItemAnimator(slot1)
end

function slot0.playDescItemAnimator(slot0, slot1)
	if slot0.showSkillDescContainer then
		if not YaXianGameModel.instance:getSkillMo(slot1.skillId) then
			return
		end

		slot3 = UIAnimationName.Idle

		if slot2.canUseCount > 0 then
			slot3 = UIAnimationName.Open
		end

		slot1.animator:Play(slot3)
	end
end

slot0.ModeSelectColor = Color.white
slot0.ModeDisSelectColor = Color(0.4, 0.4, 0.4, 1)

function slot0.refreshSkillItem(slot0, slot1)
	if not YaXianGameModel.instance:getSkillMo(slot1.skillId) then
		gohelper.setActive(slot1.goContainer, false)

		return
	end

	gohelper.setActive(slot1.goContainer, true)
	gohelper.setActive(slot1.goCanUse, slot2.canUseCount > 0)

	slot1.imgicon.color = slot2.canUseCount > 0 and uv0.ModeSelectColor or uv0.ModeDisSelectColor
	slot3 = UIAnimationName.Idle

	if slot2.canUseCount > 0 then
		slot3 = UIAnimationName.Open
	end

	slot1.animator:Play(slot3)
end

function slot0.onUpdateSkillInfo(slot0)
	slot0:refreshUI()
end

function slot0.changeSkillDescContainerVisible(slot0)
	slot0.showSkillDescContainer = not slot0.showSkillDescContainer

	gohelper.setActive(slot0.goSkillDescContent, slot0.showSkillDescContainer)
	gohelper.setActive(slot0.goSkillBlock, slot0.showSkillDescContainer)
	slot0:playDescItemAnimator(slot0.hideSkillDescItem)
	slot0:playDescItemAnimator(slot0.throughSkillDescItem)
end

function slot0.onClose(slot0)
end

function slot0.onDestroyView(slot0)
	slot0.hideSkillDescItem.click:RemoveClickListener()
	slot0.throughSkillDescItem.click:RemoveClickListener()
	slot0.skillBtn:RemoveClickListener()
	slot0.blockClick:RemoveClickListener()
end

return slot0
