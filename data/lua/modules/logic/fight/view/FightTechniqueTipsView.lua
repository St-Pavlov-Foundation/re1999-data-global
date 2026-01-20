-- chunkname: @modules/logic/fight/view/FightTechniqueTipsView.lua

module("modules.logic.fight.view.FightTechniqueTipsView", package.seeall)

local FightTechniqueTipsView = class("FightTechniqueTipsView", BaseView)

function FightTechniqueTipsView:onInitView()
	self._goclose = gohelper.findChildClick(self.viewGO, "#go_close")
	self._gocenter = gohelper.findChild(self.viewGO, "#go_center")
	self._txttemp = gohelper.findChildText(self.viewGO, "#txt_temp")
	self._simageicon = gohelper.findChildSingleImage(self.viewGO, "#go_center/#simage_icon")
	self._mask = gohelper.findChildClickWithAudio(self.viewGO, "mask")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function FightTechniqueTipsView:addEvents()
	self._goclose:AddClickListener(self._btncloseOnClick, self)
	self._mask:AddClickListener(self.closeThis, self)
end

function FightTechniqueTipsView:removeEvents()
	self._goclose:RemoveClickListener()
	self._mask:RemoveClickListener()
end

function FightTechniqueTipsView:_btncloseOnClick()
	self:closeThis()
end

function FightTechniqueTipsView:_editableInitView()
	return
end

function FightTechniqueTipsView:onUpdateParam()
	self:_refreshView()
end

function FightTechniqueTipsView:onOpen()
	self:_refreshView()
end

function FightTechniqueTipsView:_refreshView()
	if self.viewParam.isGMShow then
		self.config = self.viewParam.config
	else
		self.config = self.viewParam

		FightViewTechniqueModel.instance:readTechnique(self.config.id)
	end

	self._simageicon:LoadImage(ResUrl.getTechniqueLangIcon(self.config.picture2 or ""))

	local string_list = FightStrUtil.instance:getSplitCache(self.config.content1, "|")

	for k, v in pairs(lua_fight_technique.configDict) do
		local obj = gohelper.findChild(self.viewGO, "#go_center/content/" .. v.id)

		if obj then
			gohelper.setActive(obj, v.id == self.config.id)

			if self.config.id == v.id then
				for i, str in ipairs(string_list) do
					str = string.gsub(str, "%{", string.format("<color=%s>", "#ff906a"))
					str = string.gsub(str, "%}", "</color>")

					local textTab = obj:GetComponentsInChildren(gohelper.Type_TextMesh)

					for index = 0, textTab.Length - 1 do
						if textTab[index].gameObject.name == "txt_" .. i then
							textTab[index].text = str
						end
					end
				end
			end
		end
	end

	FightAudioMgr.instance:obscureBgm(true)
end

function FightTechniqueTipsView:onClose()
	FightAudioMgr.instance:obscureBgm(false)
end

function FightTechniqueTipsView:onDestroyView()
	self._simageicon:UnLoadImage()
end

return FightTechniqueTipsView
