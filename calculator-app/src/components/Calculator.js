import React, { useState } from 'react';
import Button from './Button';
import Display from './Display';

export default function Calculator() {
  const [value, setValue] = useState('');

  const handleClick = (label) => {
    if (label === '=') {
      setValue(eval(value)); // Simplified for example purposes
    } else if (label === 'C') {
      setValue('');
    } else {
      setValue(value + label);
    }
  };

  return (
    <div>
      <Display value={value} />
      <div>
        {['1', '2', '3', '+', 'C'].map((label) => (
          <Button key={label} label={label} onClick={() => handleClick(label)} />
        ))}
      </div>
    </div>
  );
}
