-- chunkname: @modules/logic/activity/view/ActivityNoviceSignView.lua

module("modules.logic.activity.view.ActivityNoviceSignView", package.seeall)

local ActivityNoviceSignView = class("ActivityNoviceSignView", BaseView)

function ActivityNoviceSignView:onInitView()
	self._simagebg = gohelper.findChildSingleImage(self.viewGO, "#simage_bg")
	self._simageframebg = gohelper.findChildSingleImage(self.viewGO, "character/image_frame")
	self._simagecharacter = gohelper.findChildSingleImage(self.viewGO, "character/image_character")
	self._godaylist = gohelper.findChild(self.viewGO, "#go_daylist")
	self._scrollitem = gohelper.findChildScrollRect(self.viewGO, "#go_daylist/#scroll_item")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function ActivityNoviceSignView:addEvents()
	self:addEventCb(ActivityController.instance, ActivityEvent.RefreshNorSignActivity, self._refresh, self)
end

function ActivityNoviceSignView:removeEvents()
	self:removeEventCb(ActivityController.instance, ActivityEvent.RefreshNorSignActivity, self._refresh, self)
end

function ActivityNoviceSignView:_editableInitView()
	self._txtdesc = gohelper.findChildText(self.viewGO, "activitydesc/tips/#txt_desc")
	self._txtreward = gohelper.findChildText(self.viewGO, "activitydesc/tips/#txt_reward")
	self._gostarlist = gohelper.findChild(self.viewGO, "activitydesc/tips/#go_starlist")
	self._gostaricon = gohelper.findChild(self.viewGO, "activitydesc/tips/#go_starlist/#go_staricon")
	self._actId = ActivityEnum.Activity.NoviceSign

	Activity101Rpc.instance:sendGet101InfosRequest(self._actId)
	self._simagebg:LoadImage(ResUrl.getActivityBg("full/img_bg"))
	self._simageframebg:LoadImage(ResUrl.getActivityBg("eightday/img_lihui_deco_fire"))
	self._simagecharacter:LoadImage(ResUrl.getActivityBg("eightday/char_008"))
end

function ActivityNoviceSignView:onUpdateParam()
	return
end

function ActivityNoviceSignView:onOpen()
	local parentGO = self.viewParam.parent

	gohelper.addChild(parentGO, self.viewGO)
end

function ActivityNoviceSignView:_refresh()
	local data = {}

	for i = 1, 8 do
		local o = {}

		o.data = ActivityConfig.instance:getNorSignActivityCo(self._actId, i)

		table.insert(data, o)
	end

	ActivityNoviceSignItemListModel.instance:setDayList(data)

	local co = ActivityConfig.instance:getActivityCo(self._actId)
	local boCo = string.splitToNumber(data[8].data.bonus, "#")
	local itemCo, icon = ItemModel.instance:getItemConfigAndIcon(boCo[1], boCo[2])

	if boCo[1] == MaterialEnum.MaterialType.Hero then
		if GameConfig:GetCurLangType() == LangSettings.jp then
			gohelper.setActive(self._gostarlist, false)

			local _str = co.actDesc
			local star = string.rep("<sprite=0>", 5)
			local _str2 = string.format("%s<color=#c66030>%s</color>", luaLang("activitynovicesign_character"), itemCo.name)

			self._txtdesc.text = string.format(_str, star .. _str2)
			self._txtreward.text = ""
		else
			local rewardInfo = GameConfig:GetCurLangType() == LangSettings.zh and "%s<color=#c66030>%s</color>。" or "%s<color=#c66030> %s</color>."

			gohelper.setActive(self._gostarlist, true)

			self._txtdesc.text = string.format("%s", co.actDesc)
			self._txtreward.text = string.format(rewardInfo, luaLang("activitynovicesign_character"), itemCo.name)

			if not self._hasCreateStar then
				for i = 1, 4 do
					gohelper.cloneInPlace(self._gostaricon, "star" .. i)
				end

				self._hasCreateStar = true
			end
		end
	else
		gohelper.setActive(self._gostarlist, false)

		self._txtdesc.text = string.format("%s", co.actDesc)
		self._txtreward.text = string.format("<color=#c66030>%s</color>", itemCo.name)
	end
end

function ActivityNoviceSignView:onClose()
	return
end

function ActivityNoviceSignView:onDestroyView()
	self._simagebg:UnLoadImage()
	self._simageframebg:UnLoadImage()
	self._simagecharacter:UnLoadImage()
end

return ActivityNoviceSignView
