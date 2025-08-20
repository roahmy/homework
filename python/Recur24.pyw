from pt4 import *
import re

def parse_expression(tokens, index):
    token = tokens[index[0]]
    
    if token == 'T':
        index[0] += 1
        return True
    elif token == 'F':
        index[0] += 1
        return False
    elif token == 'Not':
        index[0] += 1  # Skip 'Not'
        index[0] += 1  # Skip '('
        expr_val = parse_expression(tokens, index)
        index[0] += 1  # Skip ')'
        return not expr_val
    elif token in ['And', 'Or']:
        op = token
        index[0] += 1  # Skip operator
        index[0] += 1  # Skip '('
        args = []
        while True:
            arg = parse_expression(tokens, index)
            args.append(arg)
            if tokens[index[0]] == ')':
                index[0] += 1  # Skip ')'
                break
            index[0] += 1  # Skip ','
        return all(args) if op == 'And' else any(args)
    else:
        raise ValueError("Invalid token: " + token)

def solve():
    task("Recur24")
    s = get().strip()
    
    # Tokenize input string
    tokens = re.findall(r'\b(And|Or|Not|T|F)\b|([(),])', s)
    tokens = [t[0] if t[0] else t[1] for t in tokens if any(t)]
    
    index = [0]
    try:
        result = parse_expression(tokens, index)
        put(result)  # Directly output boolean value
    except:
        put(False)

start(solve)
