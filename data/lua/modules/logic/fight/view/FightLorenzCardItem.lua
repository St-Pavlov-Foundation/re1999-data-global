-- chunkname: @modules/logic/fight/view/FightLorenzCardItem.lua

module("modules.logic.fight.view.FightLorenzCardItem", package.seeall)

local FightLorenzCardItem = class("FightLorenzCardItem", UserDataDispose)

function FightLorenzCardItem.Create(go)
	local cardItem = FightLorenzCardItem.New()

	cardItem:init(go)

	return cardItem
end

function FightLorenzCardItem:init(go)
	FightLorenzCardItem.super.__onInit(self)

	self.go = go
	self.rectTr = go:GetComponent(gohelper.Type_RectTransform)
	self.goTips = gohelper.findChild(self.go, "Tips")
	self.goEmpty = gohelper.findChild(self.go, "Image_smallcardslot")
	self.goArrow = gohelper.findChild(self.go, "Image_arrow")
	self.simageIcon = gohelper.findChildSingleImage(self.go, "image")
	self.goIcon = gohelper.findChild(self.go, "image")
	self.animator = self.go:GetComponent(gohelper.Type_Animator)
	self.goText = gohelper.findChild(self.go, "Tips/Image/Text")
end

function FightLorenzCardItem:updateSkill()
	local skillId = FightDataHelper.operationDataMgr:getLorenzRecordSkillId()

	if not skillId then
		gohelper.setActive(self.goEmpty, true)
		gohelper.setActive(self.goTips, true)
		gohelper.setActive(self.goArrow, true)
		gohelper.setActive(self.goIcon, false)

		return
	end

	gohelper.setActive(self.goEmpty, false)
	gohelper.setActive(self.goTips, false)
	gohelper.setActive(self.goArrow, false)
	gohelper.setActive(self.goIcon, true)

	local skillCo = lua_skill.configDict[skillId]

	if not skillCo then
		logError("skill co is nil, skillId : " .. tostring(skillId))

		return
	end

	AudioMgr.instance:trigger(350024)

	local targetIconUrl = FightModel.instance:getHandCardSkillIcon(nil, skillCo)

	self.simageIcon:LoadImage(targetIconUrl)
end

function FightLorenzCardItem:show()
	gohelper.setActive(self.go, true)
	TaskDispatcher.runDelay(self.checkSubmesh, self, 0.1)

	local skillId = FightDataHelper.operationDataMgr:getLorenzRecordSkillId()

	if skillId then
		self.animator:Play("copyin")
	end
end

function FightLorenzCardItem:checkSubmesh()
	local subMeshs = self.goText:GetComponentsInChildren(typeof(TMPro.TMP_SubMeshUI), true)

	if subMeshs then
		local iter = subMeshs:GetEnumerator()

		while iter:MoveNext() do
			local subMesh = iter.Current

			subMesh.maskable = false
		end

		gohelper.setActive(self.goText, false)
		gohelper.setActive(self.goText, true)
	end
end

function FightLorenzCardItem:setAnchor(anchorX, anchorY)
	recthelper.setAnchor(self.rectTr, anchorX, anchorY)
end

function FightLorenzCardItem:hide()
	gohelper.setActive(self.go, false)
end

function FightLorenzCardItem:playAnim(animName)
	if self.go.activeSelf then
		self.animator:Play(animName, 0, 0)
	end
end

function FightLorenzCardItem:destroy()
	self.simageIcon:UnLoadImage()
	FightLorenzCardItem.super.__onDispose(self)
end

return FightLorenzCardItem
