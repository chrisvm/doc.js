remove_nodes: (ast) ->
    ignore = ['locationData']
    recv = (obj) ->
        if Array.isArray(obj)
            ret = []
            for item in obj
                ret.push(recv(item))
            return ret
        else if typeof(obj) is 'object'
            ret = {}
            for key,value of obj
                if key not in ignore
                    ret[key] = recv(value)
            return ret
        else
            return obj
    return recv(ast)

module.exports =
    remove_nodes: remove_nodes
