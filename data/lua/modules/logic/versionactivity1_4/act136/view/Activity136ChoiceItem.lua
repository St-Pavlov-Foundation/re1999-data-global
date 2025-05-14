module("modules.logic.versionactivity1_4.act136.view.Activity136ChoiceItem", package.seeall)

local var_0_0 = class("Activity136ChoiceItem", ListScrollCell)

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0._go = arg_1_1
	arg_1_0._txtnum = gohelper.findChildText(arg_1_0._go, "num/#txt_num")

	local var_1_0 = gohelper.findChild(arg_1_0._go, "go_click")

	arg_1_0._btnClick = gohelper.getClickWithAudio(var_1_0, AudioEnum.UI.UI_vertical_first_tabs_click)
	arg_1_0._goSelected = gohelper.findChild(arg_1_0._go, "select")
	arg_1_0._imagerare = gohelper.findChildImage(arg_1_0._go, "role/rare")
	arg_1_0._simageicon = gohelper.findChildSingleImage(arg_1_0._go, "role/heroicon")
	arg_1_0._imagecareer = gohelper.findChildImage(arg_1_0._go, "role/career")
	arg_1_0._txtname = gohelper.findChildText(arg_1_0._go, "role/name")
	arg_1_0._txtnameen = gohelper.findChildText(arg_1_0._go, "role/name/nameEn")
	arg_1_0._isSelected = false

	arg_1_0:addEvents()
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnClick:AddClickListener(arg_2_0._onClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnClick:RemoveClickListener()
end

function var_0_0._onClick(arg_4_0)
	if not Activity136Model.instance:isActivity136InOpen(true) then
		return
	end

	if Activity136Model.instance:hasReceivedCharacter() then
		GameFacade.showToast(ToastEnum.Activity136AlreadyReceive)

		return
	end

	local var_4_0 = not arg_4_0._isSelected
	local var_4_1

	if var_4_0 then
		var_4_1 = arg_4_0._mo and arg_4_0._mo.id
	end

	arg_4_0._view:selectCell(arg_4_0._index, var_4_0)
	Activity136Controller.instance:dispatchEvent(Activity136Event.SelectCharacter, var_4_1)
end

function var_0_0.onUpdateMO(arg_5_0, arg_5_1)
	arg_5_0._mo = arg_5_1

	local var_5_0 = HeroConfig.instance:getHeroCO(arg_5_0._mo.id)

	if not var_5_0 then
		logError("Activity136CharacterItem.onUpdateMO error, characterCfg is nil, id:" .. tostring(arg_5_0._mo.id))

		return
	end

	local var_5_1 = SkinConfig.instance:getSkinCo(var_5_0.skinId)

	if not var_5_1 then
		logError("Activity136CharacterItem.onUpdateMO error, skinCfg is nil, id:" .. tostring(var_5_0.skinId))

		return
	end

	arg_5_0._simageicon:LoadImage(ResUrl.getRoomHeadIcon(var_5_1.headIcon))
	UISpriteSetMgr.instance:setCommonSprite(arg_5_0._imagecareer, "lssx_" .. var_5_0.career)
	UISpriteSetMgr.instance:setCommonSprite(arg_5_0._imagerare, "bgequip" .. CharacterEnum.Color[var_5_0.rare])

	arg_5_0._txtname.text = var_5_0.name
	arg_5_0._txtnameen.text = var_5_0.nameEng

	local var_5_2 = 0
	local var_5_3 = var_5_0.duplicateItem

	if not string.nilorempty(var_5_3) then
		local var_5_4 = string.split(var_5_3, "|")[1]

		if var_5_4 then
			local var_5_5 = string.splitToNumber(var_5_4, "#")

			var_5_2 = ItemModel.instance:getItemQuantity(var_5_5[1], var_5_5[2])
		end
	end

	local var_5_6
	local var_5_7 = HeroModel.instance:getByHeroId(arg_5_0._mo.id)

	if var_5_7 then
		local var_5_8 = var_5_7.exSkillLevel

		var_5_6 = formatLuaLang("has_num", var_5_8 + 1 + var_5_2)
	else
		var_5_6 = luaLang("not_has")
	end

	arg_5_0._txtnum.text = var_5_6
end

function var_0_0.onSelect(arg_6_0, arg_6_1)
	arg_6_0._isSelected = arg_6_1

	gohelper.setActive(arg_6_0._goSelected, arg_6_0._isSelected)
end

function var_0_0.onDestroy(arg_7_0)
	arg_7_0._isSelected = false

	arg_7_0._simageicon:UnLoadImage()
	arg_7_0:removeEvents()
end

return var_0_0
