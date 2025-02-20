module("modules.configschecker.ConfigsCheckerStrBuf", package.seeall)

slot0 = table.insert
slot1 = string.format
slot2 = debug.getinfo
slot3 = table.concat
slot4 = class("ConfigsCheckerStrBuf")

function slot4.ctor(slot0, slot1)
	slot0:init(slot1)
end

function slot4.init(slot0, slot1)
	slot0:clean()

	slot2 = uv0(5, "Slf")
	slot0._srcloc = uv1("%s : line %s", slot2.source, slot2.currentline)
	slot0._source = slot1 or slot0._source
end

function slot4.clean(slot0)
	slot0._list = {}
	slot0._srcloc = "[Unknown]"
	slot0._source = "[Unknown]"
end

function slot4.empty(slot0)
	return #slot0._list == 0
end

function slot4._beginOnce(slot0)
	if not slot0:empty() then
		return
	end

	uv0(slot0._list, uv1("%s =========== begin", slot0._srcloc))
	uv0(slot0._list, uv1("source: %s", slot0._source))
end

function slot4._endOnce(slot0)
	if slot0._list[-11235] then
		return
	end

	slot0._list[-11235] = true

	slot0:appendLine(uv0("%s =========== end", slot0._srcloc))
end

function slot4._logIfGot(slot0, slot1, slot2)
	if slot0:empty() then
		return
	end

	slot0:_endOnce()
	slot1(uv0(slot0._list, "\n"))

	if not slot2 then
		slot0:clean()
	end
end

function slot4.appendLine(slot0, slot1)
	if type(slot1) == type(true) then
		slot1 = tostring(slot1)
	elseif slot1 == nil then
		slot1 = "nil"
	end

	slot0:_beginOnce()
	uv0(slot0._list, slot1)
end

function slot4.appendLineIfOK(slot0, slot1, slot2)
	if not slot1 then
		return
	end

	slot0:appendLine(slot2)
end

function slot4.logErrorIfGot(slot0, slot1)
	slot0:_logIfGot(logError, slot1)
end

function slot4.logWarnIfGot(slot0, slot1)
	slot0:_logIfGot(logWarn, slot1)
end

function slot4.logNormalIfGot(slot0, slot1)
	slot0:_logIfGot(logNormal, slot1)
end

return slot4
