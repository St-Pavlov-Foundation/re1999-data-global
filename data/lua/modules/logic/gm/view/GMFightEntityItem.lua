module("modules.logic.gm.view.GMFightEntityItem", package.seeall)

local var_0_0 = class("GMFightEntityItem", ListScrollCell)

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0._go = arg_1_1
	arg_1_0._btn = gohelper.findChildButtonWithAudio(arg_1_1, "btn")
	arg_1_0._selectImg = gohelper.findChildImage(arg_1_1, "btn")
	arg_1_0._icon = gohelper.findChildSingleImage(arg_1_1, "image")
	arg_1_0._imgIcon = gohelper.findChildImage(arg_1_1, "image")
	arg_1_0._imgCareer = gohelper.findChildImage(arg_1_1, "image/career")
	arg_1_0._txtName = gohelper.findChildText(arg_1_1, "btn/name")
	arg_1_0._txtId = gohelper.findChildText(arg_1_1, "btn/id")
	arg_1_0._txtUid = gohelper.findChildText(arg_1_1, "btn/uid")
end

function var_0_0.addEventListeners(arg_2_0)
	arg_2_0._btn:AddClickListener(arg_2_0._onClickThis, arg_2_0)
end

function var_0_0.removeEventListeners(arg_3_0)
	arg_3_0._btn:RemoveClickListener()
end

function var_0_0.onUpdateMO(arg_4_0, arg_4_1)
	arg_4_0._mo = arg_4_1

	arg_4_0._icon:UnLoadImage()

	if not arg_4_0._mo:isMonster() or not lua_monster.configDict[arg_4_0._mo.modelId] then
		local var_4_0 = lua_character.configDict[arg_4_0._mo.modelId]
	end

	local var_4_1 = FightConfig.instance:getSkinCO(arg_4_1.originSkin)

	if arg_4_0._mo:isCharacter() then
		local var_4_2 = ResUrl.getHeadIconSmall(var_4_1.retangleIcon)

		arg_4_0._icon:LoadImage(var_4_2)
	elseif arg_4_0._mo:isMonster() then
		gohelper.getSingleImage(arg_4_0._imgIcon.gameObject):LoadImage(ResUrl.monsterHeadIcon(var_4_1.headIcon))

		arg_4_0._imgIcon.enabled = true
	end

	local var_4_3 = arg_4_1:getCareer()

	if var_4_3 ~= 0 then
		UISpriteSetMgr.instance:setEnemyInfoSprite(arg_4_0._imgCareer, "sxy_" .. tostring(var_4_3))
	end

	local var_4_4 = arg_4_0._mo:isCharacter()
	local var_4_5 = FightDataHelper.entityMgr:isSp(arg_4_0._mo.id)
	local var_4_6 = FightDataHelper.entityMgr:isSub(arg_4_0._mo.id)
	local var_4_7 = FightDataHelper.entityMgr:isDeadUid(arg_4_0._mo.id)
	local var_4_8

	var_4_8 = arg_4_0._mo.side == FightEnum.EntitySide.MySide

	local var_4_9 = var_4_5 and "特殊怪" or (var_4_6 and "<color=#FFA500>替补</color>" or "") .. (var_4_4 and "角色" or "怪物")

	if arg_4_0._mo.id == FightEntityScene.MySideId then
		arg_4_0._txtName.text = "维尔汀"
	elseif arg_4_0._mo.id == FightEntityScene.EnemySideId then
		arg_4_0._txtName.text = "敌方维尔汀"
	else
		arg_4_0._txtName.text = string.format("%s--%s", var_4_9, arg_4_0._mo:getEntityName())
	end

	arg_4_0._txtId.text = "ID" .. tostring(arg_4_0._mo.id)
	arg_4_0._txtUid.text = "UID" .. tostring(arg_4_0._mo.modelId)

	local var_4_10 = var_4_7 and "#AAAAAA" or var_4_4 and "#539450" or "#9C4F30"

	SLFramework.UGUI.GuiHelper.SetColor(arg_4_0._txtName, var_4_10)
	SLFramework.UGUI.GuiHelper.SetColor(arg_4_0._txtId, var_4_10)
	SLFramework.UGUI.GuiHelper.SetColor(arg_4_0._txtUid, var_4_10)
	ZProj.UGUIHelper.SetGrayscale(arg_4_0._icon.gameObject, var_4_7)
end

function var_0_0.onDestroy(arg_5_0)
	arg_5_0._icon:UnLoadImage()
end

function var_0_0._onClickThis(arg_6_0)
	if not arg_6_0._isSelect then
		arg_6_0._view:setSelect(arg_6_0._mo)
	end
end

function var_0_0.onSelect(arg_7_0, arg_7_1)
	arg_7_0._isSelect = arg_7_1

	SLFramework.UGUI.GuiHelper.SetColor(arg_7_0._selectImg, arg_7_1 and "#9ADEF0" or "#FFFFFF")

	if arg_7_1 then
		GMFightEntityModel.instance:setEntityMO(arg_7_0._mo)
		GMController.instance:dispatchEvent(GMFightEntityView.Evt_SelectHero, arg_7_0._mo)
	end
end

return var_0_0
