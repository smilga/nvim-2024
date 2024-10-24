;; typescript

interface Use{{_lua:string.upper(string.sub(vim.fn.expand('%:.:r'),1,1)) .. string.sub(vim.fn.expand('%:.:r'),2)_}}

export default function use{{_lua:string.upper(string.sub(vim.fn.expand('%:.:r'),1,1)) .. string.sub(vim.fn.expand('%:.:r'),2)_}}(): Use{{_lua:string.upper(string.sub(vim.fn.expand('%:.:r'),1,1)) .. string.sub(vim.fn.expand('%:.:r'),2)_}} {
  return useState('foo', () => 'bar')
}
